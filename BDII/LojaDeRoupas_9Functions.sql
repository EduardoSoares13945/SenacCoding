-- ================================================
-- 9. FUNCTIONS
-- ================================================
DELIMITER $$
CREATE FUNCTION fn_TotalComprasCliente(p_id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(valor_total) INTO total
    FROM Venda
    WHERE id_cliente = p_id_cliente;
    RETURN IFNULL(total, 0.00);
END; $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION fn_QuantidadeEstoqueProduto(p_id_produto INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE qtd INT;
    SELECT quantidade_disponivel INTO qtd
    FROM Estoque
    WHERE id_produto = p_id_produto;
    RETURN IFNULL(qtd, 0);
END; $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION fn_DescontoProduto(p_id_produto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE preco DECIMAL(10,2);
    DECLARE desconto DECIMAL(5,2);
    SELECT p.preco, IFNULL(pm.desconto_percentual, 0)
    INTO preco, desconto
    FROM Produto p
    LEFT JOIN Promocao pm ON p.id_promocao = pm.id_promocao
    WHERE p.id_produto = p_id_produto;
    RETURN preco - (preco * desconto / 100);
END; $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION fn_TotalItensVendidos(p_id_produto INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(quantidade) INTO total
    FROM Item_Venda
    WHERE id_produto = p_id_produto;
    RETURN IFNULL(total, 0);
END; $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION fn_MaiorVendaCliente(p_id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE maior DECIMAL(10,2);
    SELECT MAX(valor_total) INTO maior
    FROM Venda
    WHERE id_cliente = p_id_cliente;
    RETURN IFNULL(maior, 0.00);
END; $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION fn_ValorTotalEstoque()
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(15,2);
    SELECT SUM(p.preco * e.quantidade_disponivel) INTO total
    FROM Produto p
    JOIN Estoque e ON p.id_produto = e.id_produto;
    RETURN IFNULL(total, 0.00);
END; $$
DELIMITER ;

-- Teste FNÇ 1
SELECT fn_TotalComprasCliente(1) AS TotalGastoPorCliente1;

-- Teste FNÇ 2
SELECT fn_QuantidadeEstoqueProduto(1) AS EstoqueProduto1;

-- Teste FNÇ 3
SELECT fn_DescontoProduto(1) AS PrecoComDesconto;

-- Teste FNÇ 4
SELECT fn_TotalItensVendidos(1) AS ItensVendidosProduto1;

-- Teste FNÇ 5
SELECT fn_MaiorVendaCliente(1) AS MaiorVendaCliente1;

-- Teste FNÇ 6
SELECT fn_ValorTotalEstoque() AS ValorTotalEmEstoque;