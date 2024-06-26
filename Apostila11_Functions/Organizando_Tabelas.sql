-- Apagando tabelas antiga;
DROP TABLE tb_cliente CASCADE;
DROP TABLE tb_pedido CASCADE;
DROP TABLE tb_tipo_item CASCADE;
DROP TABLE tb_item CASCADE;
DROP TABLE tb_item_pedido CASCADE;

-- Nova tabela cliente;
CREATE TABLE IF NOT EXISTS tb_cliente(
	cod_cliente SERIAL PRIMARY KEY
,
	nome VARCHAR(200) NOT NULL
);
-- Mostrando Resultados;
SELECT * FROM tb_cliente;
-- Nova tabela pedido;
CREATE TABLE IF NOT EXISTS tb_pedido(
	cod_pedido SERIAL PRIMARY KEY
,	data_criacao TIMESTAMP DEFAULT CuRRENT_TIMESTAMP
,	status VARCHAR(20) DEFAULT 'aberto'
,	cod_cliente INT NOT NULL
,	CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES tb_cliente(cod_cliente)
);

-- Nova tabela tipo item;
CREATE TABLE tb_tipo_item(
	cod_tipo SERIAL PRIMARY KEY
,	descricao VARCHAR(200) NOT NULL
);
-- Inserindo Valores;
INSERT INTO tb_tipo_item (descricao) VALUES ('Bebida'), ('Comida');
-- Mostrando Resultados;
SELECT * FROM tb_tipo_item;

-- Nova tabela item;
CREATE TABLE IF NOT EXISTS tb_item(
	cod_item SERIAL PRIMARY KEY
,	descricao VARCHAR(200) NOT NULL
,	valor NUMERIC(10,2) NOT NULL
,	cod_tipo INT NOT NULL
,	CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES
tb_tipo_item(cod_tipo)
);

-- Inserindo valores na tb_item;
INSERT INTO tb_item (descricao, valor, cod_tipo)
VALUES ('Refrigerante', 7, 1)
,	('Suco', 8, 1)
,	('Hamburguer', 12, 2)
,	('Batata Frita', 9, 2);

-- Nova tabela item pedido;
CREATE TABLE IF NOT EXISTS tb_item_pedido(
	--surrogate key, assim cod_item pode repetir
	cod_item_pedido SERIAL PRIMARY KEY
,	cod_item INT
,	cod_pedido INT
,	CONSTRAINT fk_item FOREIGN KEY (cod_item) REFERENCES tb_item (cod_item)
,	CONSTRAINT fk_pedido FOREIGN KEY (cod_pedido) REFERENCES tb_pedido
(cod_pedido)
);