-- Grupo: Eduardo Soares, Andrew Kauê e Pedro Moura
-- Observacao: *Desative* o modo Seguro em Edit > Preferences > SQL Editor > "Safe Updates" para executar o script sem problemas.
-- Executando de uma vez, o script pode demorar um pouco, mas não se preocupe, ele vai funcionar.

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

-- ================================================
-- 2. ALTER TABLE (DDL)
-- ================================================
ALTER TABLE Produto ADD COLUMN descricao TEXT;
ALTER TABLE Produto ADD COLUMN data_criacao DATE DEFAULT (CURRENT_DATE);
ALTER TABLE Produto MODIFY marca VARCHAR(100);
ALTER TABLE Estoque MODIFY quantidade_disponivel INT NOT NULL;
ALTER TABLE Compra ADD COLUMN status VARCHAR(20) DEFAULT 'pendente';
ALTER TABLE Compra ADD COLUMN data_entrega DATE;
ALTER TABLE Promocao ADD COLUMN data_vencimento DATE;
ALTER TABLE Cliente MODIFY telefone VARCHAR(30);
ALTER TABLE Venda ADD COLUMN observacoes TEXT;
ALTER TABLE Funcionario ADD COLUMN salario DECIMAL(10,2);

-- ================================================
-- 4. INSERTS COM DADOS (DML)
-- ================================================
INSERT INTO Categoria (nome) VALUES
('Masculino'),
('Feminino'),
('Infantil'),
('Unissex'),
('Esportivo'),
('Casual'),
('Formal'),
('Praia'),
('Inverno'),
('Verão');

INSERT INTO Promocao (descricao, desconto_percentual) VALUES
('Desconto relâmpago especial', 13.45),
('Promoção de troca de estação', 29.80),
('Liquidação de inverno', 44.21),
('Descontos progressivos imperdíveis', 12.67),
('Oferta relâmpago final de semana', 38.99),
('Desconto especial de aniversário', 24.75),
('Super saldão da fábrica', 11.90),
('Queima de estoque geral', 19.60),
('Promoção do mês do cliente', 35.00),
('Descontos exclusivos para membros', 22.10);

INSERT INTO Produto (nome, detalhes, preco, tamanho, cor, marca, id_categoria, status, id_promocao, descricao) VALUES
('Camiseta', 'Confortável para uso diário.', 79.90, 'M', 'Azul', 'Nike', 1, 'ativo', 2, 'Modelo básico em algodão.'),
('Calça', 'Ideal para o inverno.', 129.90, 'G', 'Preto', 'Adidas', 2, 'ativo', 5, 'Jeans resistente.'),
('Shorts', 'Perfeito para atividades ao ar livre.', 49.90, 'P', 'Cinza', 'Puma', 3, 'ativo', 3, 'Modelo esportivo leve.'),
('Jaqueta', 'Resistente à água.', 219.90, 'GG', 'Verde', 'North Face', 4, 'ativo', 1, 'Ideal para o frio.'),
('Regata', 'Tecido respirável.', 39.90, 'M', 'Branco', 'Under Armour', 1, 'ativo', 4, 'Para treinos intensos.'),
('Vestido', 'Elegante para eventos.', 159.90, 'M', 'Vermelho', 'Zara', 2, 'ativo', 6, 'Estilo moderno.'),
('Saia', 'Design floral leve.', 89.90, 'P', 'Rosa', 'Forever 21', 2, 'ativo', 7, 'Para dias de verão.'),
('Moletom', 'Com capuz e bolso frontal.', 119.90, 'G', 'Cinza', 'Gap', 4, 'ativo', 8, 'Super confortável.'),
('Camisa Polo', 'Corte clássico.', 99.90, 'M', 'Azul Marinho', 'Lacoste', 1, 'ativo', 9, 'Para ocasiões casuais.'),
('Macacão', 'Peça única e estilosa.', 189.90, 'U', 'Preto', 'Levi\'s', 5, 'ativo', 10, 'Tecido jeans.');

INSERT INTO Estoque (id_produto, quantidade_disponivel) VALUES
(1, 50),
(2, 30),
(3, 80),
(4, 20),
(5, 100),
(6, 40),
(7, 35),
(8, 25),
(9, 60),
(10, 15);

INSERT INTO Fornecedor (nome, endereco, telefone, email, cep) VALUES
('Confecções Brasil', 'Rua A, 123 - São Paulo', '11999990001', 'contato@confbrasil.com', '01001-000'),
('TexVest Ltda.', 'Av. das Nações, 45 - Recife', '81987654321', 'vendas@texvest.com.br', '52020-000'),
('RoupaCerta', 'Rua B, 456 - Salvador', '71988887777', 'suporte@roupacerta.com', '40301-000'),
('Estilo Fashion', 'Rua C, 789 - Porto Alegre', '51977776666', 'sac@estilofashion.com', '90010-000'),
('Global Moda', 'Av. Central, 101 - Curitiba', '41966665555', 'info@globalmoda.com', '80010-000'),
('ClothWorld', 'Rua das Roupas, 888 - BH', '31955554444', 'contato@clothworld.com', '30140-000'),
('Malharia Boa Forma', 'Rua do Tecido, 11 - SP', '11944443333', 'vendas@boaforma.com', '01120-000'),
('TramaFina', 'Rua das Costureiras, 99 - RJ', '21933332222', 'trama@finas.com', '20230-000'),
('FioNobre', 'Rua do Algodão, 77 - Manaus', '92922221111', 'contato@fionobre.com', '69005-000'),
('Malhas Tropicais', 'Av. do Sol, 555 - Natal', '84911110000', 'tropicais@malhas.com', '59020-000');

INSERT INTO Cliente (nome, telefone, email, cpf, sexo) VALUES
('João Silva', '11999887766', 'joao@gmail.com', '12345678900', 'M'),
('Maria Oliveira', '21988776655', 'maria@uol.com.br', '98765432100', 'F'),
('Carlos Santos', '31977665544', 'carlos@hotmail.com', '45678912300', 'M'),
('Ana Costa', '41966554433', 'ana@yahoo.com', '65432198700', 'F'),
('Pedro Lima', '51955443322', 'pedro@terra.com', '11223344556', 'M'),
('Fernanda Rocha', '61944332211', 'fer@outlook.com', '66778899001', 'F'),
('Ricardo Nunes', '71933221100', 'ricardo@globo.com', '77889900112', 'M'),
('Juliana Alves', '81922110099', 'julialves@gmail.com', '88990011223', 'F'),
('Lucas Ferreira', '91911009988', 'lucasf@gmail.com', '99001122334', 'M'),
('Patrícia Souza', '31900998877', 'patricia@ig.com', '10111213141', 'F');

INSERT INTO Compra (id_fornecedor, id_cliente, data_compra, valor_total) VALUES
(1, 2, '2024-03-01', 850.00),
(3, 1, '2024-02-15', 420.90),
(5, 4, '2024-01-22', 1320.00),
(7, 3, '2024-04-05', 600.50),
(2, 6, '2024-03-20', 1150.30),
(4, 8, '2024-02-28', 980.00),
(6, 5, '2024-01-10', 700.00),
(8, 7, '2024-03-15', 1245.70),
(9, 9, '2024-04-10', 1050.00),
(10, 10, '2024-04-22', 890.90);

INSERT INTO Item_Compra (id_compra, id_produto, quantidade, preco_unitario, observacoes) VALUES
(1, 1, 10, 79.90, 'Produto novo na coleção.'),
(2, 2, 5, 129.90, 'Repor estoque.'),
(3, 3, 8, 49.90, 'Alta saída de verão.'),
(4, 4, 2, 219.90, 'Jaqueta edição limitada.'),
(5, 5, 15, 39.90, 'Promoção de regatas.'),
(6, 6, 4, 159.90, 'Vestuário feminino premium.'),
(7, 7, 7, 89.90, 'Peça de alta rotação.'),
(8, 8, 3, 119.90, 'Nova linha casual.'),
(9, 9, 6, 99.90, 'Reposição padrão.'),
(10, 10, 1, 189.90, 'Compra teste.');

INSERT INTO Venda (id_cliente, data_venda, valor_total) VALUES
(1, '2024-03-03', 299.90),
(2, '2024-03-10', 450.00),
(3, '2024-03-12', 199.90),
(4, '2024-03-18', 320.50),
(5, '2024-04-01', 870.00),
(6, '2024-04-10', 740.90),
(7, '2024-04-15', 650.00),
(8, '2024-04-18', 580.00),
(9, '2024-04-20', 900.00),
(10, '2024-04-25', 1020.00);

INSERT INTO Item_Venda (id_venda, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 2, 79.90),
(2, 3, 3, 49.90),
(3, 2, 1, 129.90),
(4, 5, 4, 39.90),
(5, 6, 2, 159.90),
(6, 7, 1, 89.90),
(7, 8, 3, 119.90),
(8, 9, 2, 99.90),
(9, 10, 1, 189.90),
(10, 4, 1, 219.90);

INSERT INTO Funcionario (nome, cargo, telefone, data_nascimento, salario) VALUES
('Amanda Ribeiro', 'Vendedor', '11998765432', '1990-05-12', 2500.00),
('Carlos Pereira', 'Caixa', '21987654321', '1985-11-23', 2000.00),
('Fernanda Souza', 'Estoquista', '31976543210', '1992-03-30', 2200.00),
('João Martins', 'Gerente', '41965432109', '1979-07-17', 4500.00),
('Mariana Lima', 'Vendedor', '51954321098', '1995-01-22', 2400.00),
('Ricardo Lopes', 'Estoquista', '61943210987', '1988-12-05', 2300.00),
('Paula Fernandes', 'Caixa', '71932109876', '1993-06-14', 2100.00),
('Roberto Dias', 'Vendedor', '81921098765', '1991-09-09', 2600.00),
('Luciana Nogueira', 'Gerente', '91910987654', '1982-04-25', 4700.00),
('Gabriel Almeida', 'Vendedor', '11999887766', '1996-10-10', 2450.00);

-- ================================================
-- 5. UPDATES e DELETES (DML)
-- ================================================
UPDATE Produto SET preco = 35.00 WHERE nome = 'Camiseta';
UPDATE Produto SET status = 'inativo' WHERE id_promocao IS NOT NULL;
UPDATE Estoque SET quantidade_disponivel = 100 WHERE id_produto = 1;
UPDATE Cliente SET nome = 'Carlos Eduardo' WHERE id_cliente = 2;
UPDATE Cliente SET telefone = '21912345678' WHERE id_cliente = 3;
UPDATE Produto SET cor = 'Cinza' WHERE marca = 'Adidas';
UPDATE Venda SET valor_total = 450.00 WHERE id_venda = 2;
UPDATE Fornecedor SET telefone = '11988887777' WHERE id_fornecedor = 3;
UPDATE Fornecedor SET email = 'novofornecedor@example.com' WHERE id_fornecedor = 4;
UPDATE Item_Compra SET observacoes = 'Produto entregue com atraso' WHERE id_item_compra = 1;
UPDATE Promocao SET descricao = 'Desconto relâmpago' WHERE id_promocao = 2;
UPDATE Produto SET marca = 'Levi’s' WHERE nome = 'Calça';
UPDATE Funcionario SET cargo = 'Gerente de Loja' WHERE id_funcionario = 2;
UPDATE Funcionario SET salario = 3500.00 WHERE id_funcionario = 2;
DELETE FROM Item_Venda WHERE id_item_venda = 5;
DELETE FROM Item_Compra WHERE id_item_compra = 4;
DELETE FROM Promocao WHERE id_promocao NOT IN (SELECT DISTINCT id_promocao FROM Produto WHERE id_promocao IS NOT NULL);
DELETE FROM Funcionario WHERE cargo = 'Temporário';
DELETE FROM Cliente WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM Compra) AND id_cliente NOT IN (SELECT DISTINCT id_cliente FROM Venda);
DELETE FROM Fornecedor WHERE id_fornecedor NOT IN (SELECT DISTINCT id_fornecedor FROM Compra);
UPDATE Promocao SET desconto_percentual = 30 WHERE desconto_percentual > 30;
UPDATE Produto SET tamanho = 'M' WHERE marca = 'Nike';
UPDATE Produto SET cor = 'Rosa' WHERE id_categoria = (SELECT id_categoria FROM Categoria WHERE nome = 'Feminino');
UPDATE Item_Venda SET quantidade = 2 WHERE id_item_venda = 3;
UPDATE Produto SET detalhes = 'Calça jeans confortável e durável' WHERE nome = 'Calça';

-- ================================================
-- 6. CONSULTAS/RELATÓRIOS (DQL)
-- ================================================
SELECT c.nome AS Cliente, p.nome AS Produto, ic.quantidade, ic.preco_unitario FROM Cliente c
JOIN Compra com ON c.id_cliente = com.id_cliente
JOIN Item_Compra ic ON com.id_compra = ic.id_compra
JOIN Produto p ON ic.id_produto = p.id_produto;

SELECT p.nome, c.nome AS categoria
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria;

SELECT cl.nome AS cliente, co.data_compra, co.valor_total
FROM Cliente cl
JOIN Compra co ON cl.id_cliente = co.id_cliente;

SELECT cl.nome AS cliente, pr.nome AS produto, ic.quantidade
FROM Cliente cl
JOIN Compra co ON cl.id_cliente = co.id_cliente
JOIN Item_Compra ic ON co.id_compra = ic.id_compra
JOIN Produto pr ON ic.id_produto = pr.id_produto;

SELECT pr.nome AS produto, pm.descricao, pm.desconto_percentual
FROM Produto pr
JOIN Promocao pm ON pr.id_promocao = pm.id_promocao;

SELECT pr.nome AS produto, e.quantidade_disponivel
FROM Produto pr
JOIN Estoque e ON pr.id_produto = e.id_produto;

SELECT c.nome AS cliente, v.id_venda, v.data_venda, v.valor_total
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente;

SELECT nome, cargo, salario
FROM Funcionario
WHERE salario > 2500.00;

SELECT iv.id_venda, p.nome AS produto, iv.quantidade, iv.preco_unitario
FROM Item_Venda iv
JOIN Produto p ON iv.id_produto = p.id_produto;

SELECT f.nome AS fornecedor, c.id_compra, c.valor_total
FROM Compra c
JOIN Fornecedor f ON c.id_fornecedor = f.id_fornecedor;

SELECT cl.nome AS cliente, v.valor_total, v.observacoes
FROM Cliente cl
JOIN Venda v ON cl.id_cliente = v.id_cliente;

SELECT nome, preco
FROM Produto
WHERE preco = (SELECT MAX(preco) FROM Produto);

SELECT nome
FROM Cliente
WHERE id_cliente IN (SELECT DISTINCT id_cliente FROM Compra);

SELECT nome
FROM Produto
WHERE id_produto IN (
    SELECT id_produto
    FROM Item_Compra
    WHERE quantidade >= 10
);

SELECT descricao
FROM Promocao
WHERE id_promocao IN (SELECT DISTINCT id_promocao FROM Produto);

SELECT nome
FROM Produto
WHERE id_categoria = (SELECT id_categoria FROM Categoria WHERE nome = 'Feminino');

SELECT nome
FROM Fornecedor
WHERE id_fornecedor IN (SELECT DISTINCT id_fornecedor FROM Compra);

SELECT nome
FROM Cliente
WHERE id_cliente = (
    SELECT id_cliente
    FROM Compra
    ORDER BY valor_total DESC
    LIMIT 1
);

SELECT nome, preco
FROM Produto
WHERE preco > (SELECT AVG(preco) FROM Produto);

SELECT nome
FROM Cliente
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM Compra);

SELECT nome, salario
FROM Funcionario
WHERE salario = (SELECT MAX(salario) FROM Funcionario);

-- ================================================
-- 7. VIEWS (DDL)
-- ================================================
CREATE VIEW VendasPorCliente AS
SELECT c.nome AS Cliente, SUM(v.valor_total) AS TotalVendas
FROM Venda v
JOIN Cliente c ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente;

CREATE VIEW ProdutosEmPromocao AS
SELECT p.nome, p.preco, p.cor, p.marca, pr.descricao, pr.desconto_percentual
FROM Produto p
JOIN Promocao pr ON p.id_promocao = pr.id_promocao
WHERE p.id_promocao IS NOT NULL;

CREATE VIEW EstoquePorProduto AS
SELECT p.nome, e.quantidade_disponivel
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto;

CREATE VIEW ComprasPorFornecedor AS
SELECT f.nome AS Fornecedor, COUNT(c.id_compra) AS TotalCompras
FROM Compra c
JOIN Fornecedor f ON c.id_fornecedor = f.id_fornecedor
GROUP BY f.id_fornecedor;

CREATE VIEW ProdutosMaisVendidos AS
SELECT p.nome, SUM(iv.quantidade) AS TotalVendido
FROM Produto p
JOIN Item_Venda iv ON p.id_produto = iv.id_produto
GROUP BY p.id_produto
ORDER BY TotalVendido DESC
LIMIT 10;

CREATE VIEW ClientesComMaisCompras AS
SELECT c.nome, COUNT(co.id_compra) AS TotalCompras
FROM Cliente c
JOIN Compra co ON c.id_cliente = co.id_cliente
GROUP BY c.id_cliente
ORDER BY TotalCompras DESC
LIMIT 10;

CREATE VIEW VendasPorCategoria AS
SELECT cat.nome AS Categoria, SUM(v.valor_total) AS TotalVendas
FROM Venda v
JOIN Item_Venda iv ON v.id_venda = iv.id_venda
JOIN Produto p ON iv.id_produto = p.id_produto
JOIN Categoria cat ON p.id_categoria = cat.id_categoria
GROUP BY cat.id_categoria;

CREATE VIEW ProdutosComMenorEstoque AS
SELECT p.nome, e.quantidade_disponivel
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto
WHERE e.quantidade_disponivel < 20
ORDER BY e.quantidade_disponivel ASC;

CREATE VIEW FuncionarioSalarioMedio AS
SELECT cargo, AVG(salario) AS SalarioMedio
FROM Funcionario
GROUP BY cargo;

CREATE VIEW ClientesComVendasEmMes AS
SELECT c.nome, COUNT(v.id_venda) AS TotalVendas
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
WHERE MONTH(v.data_venda) = MONTH(CURRENT_DATE)
GROUP BY c.id_cliente;

-- ================================================
-- 8. PROCEDURES 
-- ================================================
delimiter $$
CREATE PROCEDURE RegistrarVenda (
    IN p_id_cliente INT,
    IN p_id_produto INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE preco_unitario DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    -- Buscar o preço do produto
    SELECT preco INTO preco_unitario
    FROM Produto
    WHERE id_produto = p_id_produto;

    -- Calcular valor total
    SET total = preco_unitario * p_quantidade;

    -- Inserir a venda
    INSERT INTO Venda (id_cliente, data_venda, valor_total)
    VALUES (p_id_cliente, CURRENT_DATE, total);

    -- Obter ID da venda inserida
    SET @id_venda = LAST_INSERT_ID();

    -- Inserir item da venda
    INSERT INTO Item_Venda (id_venda, id_produto, quantidade, preco_unitario)
    VALUES (@id_venda, p_id_produto, p_quantidade, preco_unitario);

    -- Atualizar o estoque
    UPDATE Estoque
    SET quantidade_disponivel = quantidade_disponivel - p_quantidade
    WHERE id_produto = p_id_produto;
END; $$
delimiter $$
CREATE PROCEDURE AtualizarEstoqueManual (
    IN p_id_produto INT,
    IN p_nova_quantidade INT
)
BEGIN
    UPDATE Estoque
    SET quantidade_disponivel = p_nova_quantidade
    WHERE id_produto = p_id_produto;
END;$$
delimiter $$
CREATE PROCEDURE RelatorioVendasPorPeriodo (
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    SELECT v.id_venda, c.nome AS cliente, v.data_venda, v.valor_total
    FROM Venda v
    JOIN Cliente c ON v.id_cliente = c.id_cliente
    WHERE v.data_venda BETWEEN p_data_inicio AND p_data_fim;
END;$$
delimiter $$
CREATE PROCEDURE RelatorioEstoqueBaixo (
    IN p_limite INT
)
BEGIN
    SELECT p.nome, e.quantidade_disponivel
    FROM Produto p
    JOIN Estoque e ON p.id_produto = e.id_produto
    WHERE e.quantidade_disponivel < p_limite;
END;$$
delimiter $$
CREATE PROCEDURE RegistrarCompraFornecedor (
    IN p_id_fornecedor INT,
    IN p_id_cliente INT,
    IN p_id_produto INT,
    IN p_quantidade INT,
    IN p_preco_unitario DECIMAL(10,2)
)
BEGIN
    DECLARE total DECIMAL(10,2);
    SET total = p_preco_unitario * p_quantidade;

    -- Criar compra
    INSERT INTO Compra (id_fornecedor, id_cliente, data_compra, valor_total)
    VALUES (p_id_fornecedor, p_id_cliente, CURRENT_DATE, total);

    SET @id_compra = LAST_INSERT_ID();

    -- Adicionar item da compra
    INSERT INTO Item_Compra (id_compra, id_produto, quantidade, preco_unitario)
    VALUES (@id_compra, p_id_produto, p_quantidade, p_preco_unitario);

    -- Atualizar estoque
    UPDATE Estoque
    SET quantidade_disponivel = quantidade_disponivel + p_quantidade
    WHERE id_produto = p_id_produto;
END;$$
delimiter $$
CREATE PROCEDURE CadastrarCliente (
    IN p_nome VARCHAR(100),
    IN p_telefone VARCHAR(30),
    IN p_email VARCHAR(100),
    IN p_cpf CHAR(11),
    IN p_sexo CHAR(1)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = p_cpf) THEN
        INSERT INTO Cliente (nome, telefone, email, cpf, sexo)
        VALUES (p_nome, p_telefone, p_email, p_cpf, p_sexo);
    END IF;
END;$$
delimiter $$
CREATE PROCEDURE AtualizarSalario (
    IN p_cargo VARCHAR(50),
    IN p_percentual DECIMAL(5,2)
)
BEGIN
    UPDATE Funcionario
    SET salario = salario + (salario * p_percentual / 100)
    WHERE cargo = p_cargo;
END; $$

-- ================================================
-- 3. SCRIPT PARA DESTRUIR TUDO (DROP)
-- ================================================
DROP TABLE IF EXISTS Item_Venda;
DROP TABLE IF EXISTS Venda;
DROP TABLE IF EXISTS Item_Compra;
DROP TABLE IF EXISTS Compra;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Fornecedor;
DROP TABLE IF EXISTS Estoque;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Promocao;
DROP DATABASE IF EXISTS LojaDeRoupas;