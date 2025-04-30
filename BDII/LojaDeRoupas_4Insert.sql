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
