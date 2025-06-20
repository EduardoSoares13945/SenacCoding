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

-- Teste PRC 1
CALL RegistrarVenda(1, 1, 2);
CALL RegistrarVenda(3, 1, 4);
SELECT * FROM Venda ORDER BY id_venda DESC LIMIT 1;
SELECT * FROM Item_Venda ORDER BY id_item_venda DESC LIMIT 1;
SELECT * FROM Estoque WHERE id_produto = 1;

-- Teste PRC 2
CALL AtualizarEstoqueManual(1, 999);
SELECT * FROM Estoque WHERE id_produto = 1;

-- Teste PRC 3
CALL RelatorioVendasPorPeriodo('2024-03-01', '2024-04-30');

-- Teste PRC 4
CALL RelatorioEstoqueBaixo(30);

-- Teste PRC 5
CALL RegistrarCompraFornecedor(1, 1, 2, 3, 129.90);
SELECT * FROM Compra ORDER BY id_compra DESC LIMIT 1;
SELECT * FROM Item_Compra ORDER BY id_item_compra DESC LIMIT 1;
SELECT * FROM Estoque WHERE id_produto = 2;

-- Teste PRC 6
CALL CadastrarCliente('Teste Cliente', '11912345678', 'teste@exemplo.com', '12312312312', 'M');
CALL CadastrarCliente('Teste Cliente Repetido', '11912345678', 'teste@exemplo.com', '12312312312', 'M'); -- esse NÃO deve funcionar
SELECT * FROM Cliente WHERE cpf = '12312312312';

-- Teste PRC 7
CALL AtualizarSalario('Vendedor', 10);
SELECT nome, cargo, salario FROM Funcionario WHERE cargo = 'Vendedor';