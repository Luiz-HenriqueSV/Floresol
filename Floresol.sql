CREATE DATABASE IF NOT EXISTS bank_adm;
USE bank_adm;


CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100) NOT NULL,
    email_cliente VARCHAR(60) UNIQUE,
    cpf_cliente CHAR(11) NOT NULL UNIQUE,
    idade_cliente INT NOT NULL,
    datanas_cliente DATE NOT NULL
) ;

CREATE TABLE Loja (
    id_loja INT PRIMARY KEY AUTO_INCREMENT,
    cnpj_loja CHAR(14) NOT NULL UNIQUE,
    email_loja VARCHAR(100),
    nome VARCHAR(60) NOT NULL
) ;

CREATE TABLE FormaPagamento (
    id_formapagamento INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(18) NOT NULL,
    parcela INT
) ;

CREATE TABLE Delivery (
    id_delivery INT PRIMARY KEY AUTO_INCREMENT,
    frete_delivery DECIMAL(10,2) NOT NULL,
    codrastreio_delivery BIGINT NOT NULL UNIQUE,
    StTransporte_delivery VARCHAR(15)
) ;

CREATE TABLE Personalizado (
    id_personalizado INT PRIMARY KEY AUTO_INCREMENT,
    taxa_personalizado DECIMAL(10,2),
    descricao_personalizado VARCHAR(120)
) ;

CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(70) NOT NULL,
    cnpj_fornecedor CHAR(14) NOT NULL UNIQUE,
    site VARCHAR(100)
) ;

CREATE TABLE Endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(8),
    rua VARCHAR(40) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(40),
    cidade VARCHAR(40),
    sgestado CHAR(2)
) ;

CREATE TABLE Telefone (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(20) NOT NULL  
) ;

CREATE TABLE Funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome_funcionario VARCHAR(150) NOT NULL,
    idade_funcionario INT NOT NULL,
    cpf_funcionario CHAR(11) NOT NULL UNIQUE,
    rg_funcionario CHAR(20) NOT NULL UNIQUE,
    datanas_funcionario DATE NOT NULL,
    email_funcionario VARCHAR(100) UNIQUE,
    cargo_funcionario VARCHAR(30) NOT NULL,
    sexo_funcionario CHAR(1) NOT NULL,
    salario_funcionario DECIMAL(10,2) NOT NULL DEFAULT 1518,00,
    id_loja INT,
    CONSTRAINT ch_funcionario_sexo CHECK (sexo_funcionario IN ('f','m')),
    CONSTRAINT ch_funcionario_salario CHECK (salario_funcionario > 0),
    FOREIGN KEY (id_loja) REFERENCES Loja(id_loja) 
) ;

CREATE TABLE Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    tipo_produto VARCHAR(40) NOT NULL,
    nome_produto VARCHAR(80) NOT NULL,
    descricao_produto VARCHAR(200),
    preco_produto DECIMAL(10,2) NOT NULL,
    quantidade_produto INT NOT NULL,
    tamanho_produto DECIMAL(6,2),
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor) 
) ;

CREATE TABLE Login(

id_login int primary key auto_increment,
id_funcionario int unique,
Usuario varchar(100) not null unique,
Senha varchar(50) not null,
FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario) 
);



CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2) NOT NULL,
    data_transacao datetime NOT NULL,
    hora_transacao TIME NOT NULL,
    id_cliente INT,
    id_loja INT,
    id_formapagamento INT,
    id_delivery INT,
    id_personalizado INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ,
    FOREIGN KEY (id_loja) REFERENCES Loja(id_loja) ,
    FOREIGN KEY (id_formapagamento) REFERENCES FormaPagamento(id_formapagamento) ,
    FOREIGN KEY (id_delivery) REFERENCES Delivery(id_delivery) ,
    FOREIGN KEY (id_personalizado) REFERENCES Personalizado(id_personalizado) 
) ;


CREATE TABLE Cliente_has_Endereco (
    id_cliente INT,
    id_endereco INT,
    PRIMARY KEY (id_cliente, id_endereco),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco) 
) ;

CREATE TABLE Loja_has_Endereco (
    id_loja INT,
    id_endereco INT,
    PRIMARY KEY (id_loja, id_endereco),
    FOREIGN KEY (id_loja) REFERENCES Loja(id_loja) ,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco) 
) ;

CREATE TABLE Endereco_has_Funcionarios (
    id_endereco INT,
    id_funcionario INT,
    PRIMARY KEY (id_endereco, id_funcionario),
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco) ,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario)
) ;

CREATE TABLE Endereco_has_Fornecedor (
    id_endereco INT,
    id_fornecedor INT,
    PRIMARY KEY (id_endereco, id_fornecedor),
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco) ,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor) 
) ;

CREATE TABLE Telefone_has_Cliente (
    id_telefone INT,
    id_cliente INT,
    PRIMARY KEY (id_telefone, id_cliente),
    FOREIGN KEY (id_telefone) REFERENCES Telefone(id_telefone) ,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) 
) ;

CREATE TABLE Telefone_has_Funcionarios (
    id_telefone INT,
    id_funcionario INT,
    PRIMARY KEY (id_telefone, id_funcionario),
    FOREIGN KEY (id_telefone) REFERENCES Telefone(id_telefone) ,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario) 
) ;

CREATE TABLE Telefone_has_Fornecedor (
    id_telefone INT,
    id_fornecedor INT,
    PRIMARY KEY (id_telefone, id_fornecedor),
    FOREIGN KEY (id_telefone) REFERENCES Telefone(id_telefone) ,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor) 
) ;

CREATE TABLE Pedido_has_Produto (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto) 
) ;

INSERT INTO Loja (cnpj_loja, email_loja, nome)
VALUES ('12345678000199', 'aliahcristina2017@gmail.com', 'Floricultura Floresol');


INSERT INTO Funcionario 
(nome_funcionario, idade_funcionario, cpf_funcionario, rg_funcionario, datanas_funcionario, 
 email_funcionario, cargo_funcionario, sexo_funcionario, salario_funcionario, id_loja)
VALUES
('Alana Barbosa do Patrocinio', 
 17, '11122233345', '45.123.456-7', '2008-04-07',
 'alana.patrocinio@gmail.com', 'Caixa', 'f', 1518,00, 1),

('Aliah Cristina Lourenço dos Reis', 
 17, '22233344456', '44.987.654-3', '2007-10-28',
 'aliah.reis@gmail.com', 'Marketing', 'f', 1518,00, 1),

('Amanda Aguiar Alves da Silva', 
 17, '33344455567', '42.567.890-1', '2007-12-23',
 'amanda.alves@gmail.com', 'Florista', 'f', 1518,00, 1),

('Guilhermina Souza Santana', 
 16, '44455566678', '48.456.321-9', '2008-05-12',
 'guilhermina.santana@gmail.com', 'Limpeza', 'f', 1518,00, 1),

('Maria Eduarda de Moura Alves', 
 17, '55566677789', '52.789.654-0', '2008-02-27',
 'maria.eduarda@gmail.com', 'Contabilidade e Finanças', 'f', 1518,00, 1);
 
 select*from Funcionario
