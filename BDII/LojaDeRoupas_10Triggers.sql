-- ================================================
-- 10. TRIGGERS
-- ================================================
DELIMITER $$
CREATE TRIGGER trg_before_insert_venda_vendas
BEFORE INSERT ON Item_Venda
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;

    SELECT quantidade_disponivel
    INTO estoque_atual
    FROM Estoque
    WHERE id_produto = NEW.id_produto;

    IF estoque_atual < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estoque insuficiente para venda';
    ELSE
        UPDATE Estoque
        SET quantidade_disponivel = estoque_atual - NEW.quantidade
        WHERE id_produto = NEW.id_produto;
    END IF;
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trg_before_insert_venda
BEFORE INSERT ON Venda
FOR EACH ROW
BEGIN
    IF NEW.data_venda IS NULL THEN
        SET NEW.data_venda = CURRENT_DATE();
    END IF;
END; $$
DELIMITER ;

-- Essa daqui tem que ser modificada, viu?
delimiter $$
CREATE TRIGGER trg_after_update_produto
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
  IF OLD.preco <> NEW.preco OR OLD.descricao <> NEW.descricao THEN
    INSERT INTO historico_produto
      (id_produto, data_alteracao, preco_antigo, preco_novo, desc_antiga, desc_nova)
    VALUES
      (OLD.id_produto, NOW(), OLD.preco, NEW.preco, OLD.descricao, NEW.descricao);
  END IF;
END;
delimiter ;

DELIMITER $$
CREATE TRIGGER trg_before_delete_cliente
BEFORE DELETE ON Cliente
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt
    FROM Venda
    WHERE id_cliente = OLD.id_cliente;

    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir cliente com vendas.';
    END IF;
END; $$
DELIMITER ;

-- Mesma coisa essa aqui
delimiter $$
CREATE TRIGGER trg_after_update_Item_Venda
AFTER UPDATE ON Item_Venda
FOR EACH ROW
BEGIN
  DECLARE total_itens INT;
  DECLARE itens_entregues INT;
  SELECT COUNT(*) INTO total_itens FROM Item_Venda WHERE id_venda = NEW.id_venda;
  SELECT COUNT(*) INTO itens_entregues FROM Item_Venda WHERE id_venda = NEW.id_venda AND entregue = TRUE;
  IF total_itens > 0 AND total_itens = itens_entregues THEN
    UPDATE venda
      SET status_pedido = 'ENTREGUE'
      WHERE id_venda = NEW.id_venda;
  END IF;
END;
delimiter ;

-- e essa
delimiter $$
CREATE TRIGGER trg_after_insert_cliente
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
  INSERT INTO mensagens_sistema (id_cliente, mensagem, data_envio)
  VALUES (NEW.id_cliente, 'Bem-vindo(a) à nossa loja!', NOW());
END;
delimiter ;

-- Teste do TRG 1
-- Pré-requisito: produto com quantidade suficiente (ex: id_produto = 1)
UPDATE produto SET quantidade = 5 WHERE id_produto = 1;

-- Teste com estoque suficiente
INSERT INTO Item_Venda (id_venda, id_produto, quantidade) VALUES (1, 1, 2);

-- Verificar se estoque foi decrementado
SELECT quantidade FROM produto WHERE id_produto = 1;

-- Teste com estoque INSUFICIENTE (deve disparar erro)
INSERT INTO Item_Venda (id_venda, id_produto, quantidade) VALUES (1, 1, 100);

-- Teste do TRG 2
-- Inserir venda sem data
INSERT INTO venda (id_cliente, valor_total) VALUES (1, 150.00);

-- Verificar se a data foi preenchida corretamente
SELECT * FROM venda ORDER BY id_venda DESC LIMIT 1;

-- Teste do TRG 4
-- Cliente com vendas (ex: id_cliente = 1)
DELETE FROM cliente WHERE id_cliente = 1; -- Deve falhar

-- Cliente sem vendas (criar novo para teste)
INSERT INTO cliente (nome, telefone, email, cpf, sexo)
VALUES ('Teste Trigger', '11911111111', 'teste@x.com', '99999999999', 'M');
DELETE FROM cliente WHERE cpf = '99999999999'; -- Deve funcionar

