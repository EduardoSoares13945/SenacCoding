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