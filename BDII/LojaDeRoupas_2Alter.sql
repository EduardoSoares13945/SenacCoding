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
ALTER TABLE cliente ADD COLUMN data_ultima_venda DATE DEFAULT NULL;
