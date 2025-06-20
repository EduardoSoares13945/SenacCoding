-- ================================================
-- 10. TRIGGERS
-- ================================================
-- Trigger 1
DELIMITER $$
CREATE TRIGGER trg_valida_valor_total_venda
AFTER INSERT ON item_venda
FOR EACH ROW
BEGIN
  DECLARE valor_total_item DECIMAL(10,2);
  
  SET valor_total_item = NEW.quantidade * NEW.preco_unitario;

  UPDATE venda
  SET valor_total = IFNULL(valor_total, 0) + valor_total_item
  WHERE id_venda = NEW.id_venda;
END;
$$
DELIMITER ;

-- Trigger 2
DELIMITER $$
CREATE TRIGGER trg_before_insert_venda
BEFORE INSERT ON venda
FOR EACH ROW
BEGIN
    IF NEW.data_venda IS NULL THEN
        SET NEW.data_venda = CURRENT_DATE();
    END IF;
END; $$
DELIMITER ;

-- Trigger 3
DELIMITER $$
CREATE TRIGGER trg_update_data_ultima_venda
AFTER INSERT ON venda
FOR EACH ROW
BEGIN
  UPDATE cliente
  SET data_ultima_venda = NEW.data_venda
  WHERE id_cliente = NEW.id_cliente;
END;
$$
DELIMITER ;

-- Trigger 4
DELIMITER $$
CREATE TRIGGER trg_before_delete_cliente
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt
    FROM venda
    WHERE id_cliente = OLD.id_cliente;

    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir cliente com vendas.';
    END IF;
END; $$
DELIMITER ;

-- Trigger 5
DELIMITER $$
CREATE TRIGGER trg_bloqueia_venda_estoque_zero
BEFORE INSERT ON item_venda
FOR EACH ROW
BEGIN
  DECLARE qtd_estoque INT;

  SELECT quantidade_disponivel INTO qtd_estoque
  FROM estoque
  WHERE id_produto = NEW.id_produto;

  IF qtd_estoque <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Estoque insuficiente para realizar a venda.';
  END IF;
END;
$$
DELIMITER ;

-- Trigger 6
DELIMITER $$
CREATE TRIGGER trg_atualiza_estoque_apos_venda
AFTER INSERT ON item_venda
FOR EACH ROW
BEGIN
  UPDATE estoque
  SET quantidade_disponivel = quantidade_disponivel - NEW.quantidade
  WHERE id_produto = NEW.id_produto;
END;
$$
DELIMITER ;

-- Teste TRG 1
-- Variável para armazenar o último id_venda inserido
SET @novo_id_venda = 0;

-- Inserir uma nova venda com valor_total zerado
INSERT INTO venda (id_cliente, valor_total)
VALUES (1, 0.00);

-- Capturar o último id_venda inserido
SET @novo_id_venda = LAST_INSERT_ID();

-- Inserir o primeiro item_venda usando o id capturado
INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario)
VALUES (@novo_id_venda, 1, 2, 50.00);

-- Verificar o valor_total atualizado na venda
SELECT valor_total FROM venda WHERE id_venda = @novo_id_venda;

-- Inserir um segundo item_venda na mesma venda
INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario)
VALUES (@novo_id_venda, 2, 1, 80.00);

-- Verificar o valor_total atualizado novamente
SELECT valor_total FROM venda WHERE id_venda = @novo_id_venda;

-- Teste do TRG 2
-- Inserir venda sem data
INSERT INTO venda (id_cliente, valor_total) VALUES (1, 150.00);

-- Verificar se a data foi preenchida corretamente
SELECT * FROM venda ORDER BY id_venda DESC LIMIT 1;

-- Teste do TRG 3
-- Verifique o valor atual de data_ultima_venda do cliente
SELECT id_cliente, nome, data_ultima_venda 
FROM cliente 
WHERE id_cliente = 1;

-- Insira uma nova venda para esse cliente
INSERT INTO venda (id_cliente, valor_total)
VALUES (1, 100.00);

-- Verifique novamente se data_ultima_venda foi atualizada
SELECT id_cliente, nome, data_ultima_venda 
FROM cliente 
WHERE id_cliente = 1;

-- Teste do TRG 4
-- Cliente com vendas (ex: id_cliente = 1)
DELETE FROM cliente WHERE id_cliente = 1; -- Deve falhar

-- Cliente sem vendas (criar novo para teste)
INSERT INTO cliente (nome, telefone, email, cpf, sexo)
VALUES ('Teste Trigger', '11911111111', 'teste@x.com', '99999999999', 'M');

DELETE FROM cliente WHERE cpf = '99999999999'; -- Deve funcionar

-- Teste do TRG 5
-- Zerar o estoque do produto 2
UPDATE estoque SET quantidade_disponivel = 0 WHERE id_produto = 2;

-- Tentar inserir item de venda com produto sem estoque
-- Isso DEVE gerar um erro: 'Estoque insuficiente para realizar a venda.'
INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario)
VALUES (1, 2, 1, 50.00);

-- Teste do TRG 6
-- Ver estoque atual do produto 3
SELECT quantidade_disponivel FROM estoque WHERE id_produto = 3;

-- Inserir item de venda (quantidade 2)
-- O estoque será reduzido automaticamente pela trigger
INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario)
VALUES (1, 3, 2, 80.00);

-- Verificar se o estoque foi reduzido corretamente
SELECT quantidade_disponivel FROM estoque WHERE id_produto = 3;
-- Esperado: estoque reduzido em 2 unidades
