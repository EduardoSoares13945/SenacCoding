-- ================================================
-- 1. CRIAÇÃO DAS TABELAS (DDL)
-- ================================================
CREATE DATABASE IF NOT EXISTS LojaDeRoupas;
USE LojaDeRoupas;

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Promocao (
    id_promocao INT AUTO_INCREMENT PRIMARY KEY,
    descricao TEXT,
    desconto_percentual DECIMAL(5,2)
);

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    detalhes TEXT,
    preco DECIMAL(10,2) NOT NULL,
    tamanho VARCHAR(10),
    cor VARCHAR(30),
    marca VARCHAR(50),
    id_categoria INT,
    status VARCHAR(20) DEFAULT 'ativo',
    id_promocao INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (id_promocao) REFERENCES Promocao(id_promocao)
);

CREATE TABLE Estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    quantidade_disponivel INT,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    cep VARCHAR(10)
);

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    cpf CHAR(11) UNIQUE,
    sexo CHAR(1)
);

CREATE TABLE Compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_fornecedor INT,
    id_cliente INT,
    data_compra DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Item_Compra (
    id_item_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_compra INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    observacoes TEXT,
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_venda DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Item_Venda (
    id_item_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_venda) REFERENCES Venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    telefone VARCHAR(30),
    data_nascimento DATE
);