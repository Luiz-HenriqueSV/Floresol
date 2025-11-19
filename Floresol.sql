create database if not exists bank_adm;
use bank_adm;

create table Cliente (
    id_cliente int primary key auto_increment,
    nome_cliente varchar(100) not null,
    email_cliente varchar(60),
    cpf_cliente char(11) not null,
    idade_cliente int not null,
    datanas_cliente date not null,
    constraint ch_cliente unique(cpf_cliente),
    constraint ch_cliente2 unique(email_cliente)
);

create table Loja(
    id_loja int primary key,
    cnpj_loja char(14) not null,
    email_loja varchar(100),
    nome varchar(60) not null
);

create table FormaPagamento(
    id_formapagamento int primary key,
    tipo varchar(18) not null,
    parcela int
);

create table Delivery(
    id_delivery int primary key,
    frete_deliveri decimal(10,2) not null,
    codrastreio_delivery bigint not null,
    StTransporte_delivery varchar(15),
    constraint ch_delivery unique(codrastreio_delivery)
);

create table Personalizado (
    id_personalizado int primary key,
    taxa_personalizado decimal(10,2),
    descricao_personalizado varchar(120)
);

create table Fornecedor (
    id_fornecedor int primary key,
    nome_fornecedor varchar(70) not null,
    cnpj_fornecedor char(14) not null,
    site varchar(40),
    constraint ch_fornecedor unique (cnpj_fornecedor),
    constraint ch_fornecedor2 unique (nome_fornecedor)
);

create table Endereco(
    id_endereco int primary key auto_increment,
    cep char(8),
    rua varchar(40) not null,
    numero int not null,
    bairro varchar(40),
    cidade varchar(40),
    sgestado varchar(2)
);

create table Telefone (
    id_telefone int primary key,
    numero varchar(14)
);

create table Funcionario(
    id_funcionario int primary key,
    nome_funcionario varchar(150) not null,
    idade_funcionario int not null,
    cpf_funcionario char(11) not null,
    rg_funcionario char(11) not null,
    datanas_funcionario date not null,
    email_funcionario varchar(100),
    cargo_funcionario varchar(20) not null,
    sexo_funcionario varchar(1) not null,
    salario_funcionario decimal(10,2) not null default 1518,
    id_loja int,
    foreign key (id_loja) references Loja(id_loja),
    constraint ch_funcionario unique (rg_funcionario),
    constraint ch_funcionario2 unique (cpf_funcionario),
    constraint ch_funcionario3 unique (email_funcionario),
    constraint ch_funcionario4 check (sexo_funcionario in('f','m')),
    constraint ch_funcionario5 check (salario_funcionario > 0)
);

create table Produto (
    id_produto int primary key,
    tipo_produto varchar(20) not null,
    nome_produto varchar(40) not null,
    preco_produto decimal(10,2) not null,
    quantidade_produto int not null,
    tamanho_produto decimal(4,2),
    id_fornecedor int,
    foreign key (id_fornecedor) references Fornecedor(id_fornecedor)
);

create table Pedido (
    id_pedido int primary key,
    valor decimal(10,2) not null,
    data_transacao date not null,
    hora_transacao time not null,
    id_cliente int,
    id_loja int,
    id_formapagamento int,
    id_delivery int,
    id_personalizado int,
    foreign key (id_cliente) references Cliente(id_cliente),
    foreign key (id_loja) references Loja(id_loja),
    foreign key (id_formapagamento) references FormaPagamento(id_formapagamento),
    foreign key (id_delivery) references Delivery(id_delivery),
    foreign key (id_personalizado) references Personalizado(id_personalizado)
);



create table Cliente_has_Endereco (
    id_cliente int,
    id_endereco int,
    primary key (id_cliente, id_endereco),
    foreign key (id_cliente) references Cliente(id_cliente),
    foreign key (id_endereco) references Endereco(id_endereco)
);

create table Loja_has_Endereco (
    id_loja int,
    id_endereco int,
    primary key (id_loja, id_endereco),
    foreign key (id_loja) references Loja(id_loja),
    foreign key (id_endereco) references Endereco(id_endereco)
);

create table Endereco_has_Funcionarios (
    id_endereco int,
    id_funcionario int,
    primary key (id_endereco, id_funcionario),
    foreign key (id_endereco) references Endereco(id_endereco),
    foreign key (id_funcionario) references Funcionario(id_funcionario)
);

create table Endereco_has_Fornecedor (
    id_endereco int,
    id_fornecedor int,
    primary key (id_endereco, id_fornecedor),
    foreign key (id_endereco) references Endereco(id_endereco),
    foreign key (id_fornecedor) references Fornecedor(id_fornecedor)
);

create table Telefone_has_Cliente (
    id_telefone int,
    id_cliente int,
    primary key (id_telefone, id_cliente),
    foreign key (id_telefone) references Telefone(id_telefone),
    foreign key (id_cliente) references Cliente(id_cliente)
);

create table Telefone_has_Funcionarios (
    id_telefone int,
    id_funcionario int,
    primary key (id_telefone, id_funcionario),
    foreign key (id_telefone) references Telefone(id_telefone),
    foreign key (id_funcionario) references Funcionario(id_funcionario)
);

create table Telefone_has_Fornecedor (
    id_telefone int,
    id_fornecedor int,
    primary key (id_telefone, id_fornecedor),
    foreign key (id_telefone) references Telefone(id_telefone),
    foreign key (id_fornecedor) references Fornecedor(id_fornecedor)
);

create table Pedido_has_Produto (
    id_pedido int,
    id_produto int,
    quantidade int not null,
    primary key (id_pedido, id_produto),
    foreign key (id_pedido) references Pedido(id_pedido),
    foreign key (id_produto) references Produto(id_produto)
);
