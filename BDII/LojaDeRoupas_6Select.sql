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