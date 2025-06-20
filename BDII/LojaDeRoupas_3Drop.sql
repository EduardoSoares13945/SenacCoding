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
DROP TRIGGER IF EXISTS trg_valida_valor_total_venda;
DROP TRIGGER IF EXISTS trg_before_insert_venda;
DROP TRIGGER IF EXISTS trg_update_data_ultima_venda;
DROP TRIGGER IF EXISTS trg_before_delete_cliente;
DROP TRIGGER IF EXISTS trg_bloqueia_venda_estoque_zero;
DROP TRIGGER IF EXISTS trg_atualiza_estoque_apos_venda;
DROP DATABASE IF EXISTS LojaDeRoupas;