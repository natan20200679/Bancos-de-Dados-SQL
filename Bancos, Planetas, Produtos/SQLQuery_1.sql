CREATE TABLE produtos (
    codigo INT NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    data_validade DATETIME,
    ean VARCHAR(15) not NULL,
    ind_inativo int NOT NULL DEFAULT 0
)
ALTER TABLE produtos add CONSTRAINT PK_produtos PRIMARY KEY (codigo)
create index IDX01_produtos ON produtos (ean)
INSERT into produtos VALUES (1,'Nome do Produto',GETDATE(),'1234567890',0)
INSERT into produtos (codigo,descricao,ean) VALUES (2,'Nome do Produto 2','1234567890') 
SELECT * FROM produtos WHERE codigo = 2
SELECT * FROM produtos WHERE descricao LIKE '%Produto'
SELECT COUNT(*) AS total FROM produtos

CREATE TABLE lojas (
    codigo INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    ind_inativo INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_lojas PRIMARY KEY (codigo)
)
INSERT into lojas (codigo,nome) VALUES (1000,'Filial Nova Iguaçu')
INSERT into lojas (codigo,nome) VALUES (2000,'Filial São Paulo')
INSERT into lojas (codigo,nome) VALUES (3000,'Filial Recife')
SELECT * FROM lojas

CREATE TABLE estoque (
    codigo_produto INT NOT NULL,
    codigo_filial INT NOT NULL,
    quantidade DECIMAL NOT NULL DEFAULT 0,
    CONSTRAINT PK_estoque PRIMARY KEY (codigo_produto,codigo_filial)
)
INSERT into estoque (codigo_produto,codigo_filial,quantidade) VALUES (99,10,1) /* Esses valores 
estão incorretos do ponto de vista organizacional ou lógico (codigo_produto existe a partir de 1000, 
codigo_filial envolve quantidade de códigos muito abaixo de 10) */
ALTER TABLE estoque ADD CONSTRAINT FK_estoque_produtos FOREIGN KEY (codigo_produto) REFERENCES
produtos (codigo) /* As instruções (linhas 36 e 37) impedem erros organizacionais ou lógicos nas 
inserções de dados */
ALTER TABLE estoque ADD CONSTRAINT FK_estoque_lojas FOREIGN KEY (codigo_produto) REFERENCES
produtos (codigo) /* As instruções (linhas 39 e 40) impedem erros organizacionais ou lógicos nas 
inserções de dados */

DROP TABLE loja /* Por questão organizacional ou de compreensão, optou-se por trocar "loja" por
"lojas" */
ALTER TABLE estoque drop CONSTRAINT FK_estoque_lojas /* Correção de erro executado pelo instrutor 
nas linhas 39 e 40 ao inserir validação de chave primária referente à lojas na tabela de produtos, 
coluna codigo_produto */

ALTER TABLE estoque ADD CONSTRAINT FK_estoque_lojas FOREIGN KEY (codigo_filial) REFERENCES
lojas (codigo)

SELECT e.codigo_filial, l.nome, e.codigo_produto, p.descricao, e.quantidade
FROM estoque e INNER JOIN lojas l ON e.codigo_filial = l.codigo INNER JOIN produtos p
ON e.codigo_produto = p.codigo

INSERT into estoque (codigo_produto,codigo_filial,quantidade) VALUES (1,1000,10) 