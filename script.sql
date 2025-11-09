CREATE DATABASE petshop_db;
USE petshop_db;

CREATE TABLE cliente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf CHAR(11) NOT NULL UNIQUE,
  telefone VARCHAR(15),
  email VARCHAR(100)
);

CREATE TABLE pet (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  nome VARCHAR(80) NOT NULL,
  especie ENUM('cachorro','gato','outro') NOT NULL,
  porte ENUM('pequeno','medio','grande') NOT NULL,
  nascimento DATE,
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE servico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,
  preco DECIMAL(8,2) NOT NULL CHECK (preco >= 0),
  duracao_min INT NOT NULL CHECK (duracao_min > 0)
);

CREATE TABLE agendamento (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pet_id INT NOT NULL,
  servico_id INT NOT NULL,
  data_hora DATETIME NOT NULL,
  status ENUM('agendado','concluido','cancelado') DEFAULT 'agendado',
  observacoes TEXT,
  FOREIGN KEY (pet_id) REFERENCES pet(id),
  FOREIGN KEY (servico_id) REFERENCES servico(id),
  INDEX (data_hora)
);

INSERT INTO cliente (nome, cpf, telefone, email)
VALUES 
('Ana Silva', '12345678901', '47999999999', 'ana@email.com'),
('Bruno Costa', '98765432100', '47988888888', 'bruno@email.com'),
('Carla Souza', '45678912300', '47977777777', 'carla@email.com');

INSERT INTO pet (cliente_id, nome, especie, porte, nascimento)
VALUES
(1, 'Rex', 'cachorro', 'grande', '2018-06-12'),
(2, 'Mimi', 'gato', 'pequeno', '2020-09-05'),
(3, 'Thor', 'cachorro', 'medio', '2021-02-14');

INSERT INTO servico (nome, preco, duracao_min)
VALUES
('Banho', 50.00, 40),
('Tosa', 70.00, 60),
('Vacina', 120.00, 30);

INSERT INTO agendamento (pet_id, servico_id, data_hora, status, observacoes)
VALUES
(1, 1, '2025-11-20 14:00:00', 'agendado', 'Primeiro banho do mês'),
(2, 3, '2025-11-22 10:00:00', 'agendado', 'Vacina anual'),
(3, 2, '2025-11-25 16:30:00', 'agendado', 'Tosa de manutenção');
