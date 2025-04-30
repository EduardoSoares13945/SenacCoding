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