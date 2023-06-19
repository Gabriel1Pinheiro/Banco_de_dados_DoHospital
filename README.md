
# O Hospital Fundamental

Analise a seguinte descrição e extraia dela os requisitos para o banco de dados:
O hospital necessita de um sistema para sua área clínica que ajude a controlar consultas realizadas. Os médicos podem ser generalistas, especialistas ou residentes e têm seus dados pessoais cadastrados em planilhas digitais. Cada médico pode ter uma ou mais especialidades, que podem ser pediatria, clínica geral, gastroenterologia e dermatologia. Alguns registros antigos ainda estão em formulário de papel, mas será necessário incluir esses dados no novo sistema.

Os pacientes também precisam de cadastro, contendo dados pessoais (nome, data de nascimento, endereço, telefone e e-mail), documentos (CPF e RG) e convênio. Para cada convênio, são registrados nome, CNPJ e tempo de carência.

As consultas também têm sido registradas em planilhas, com data e hora de realização, médico responsável, paciente, valor da consulta ou nome do convênio, com o número da carteira. Também é necessário indicar na consulta qual a especialidade buscada pelo paciente.

Deseja-se ainda informatizar a receita do médico, de maneira que, no encerramento da consulta, ele possa registrar os medicamentos receitados, a quantidade e as instruções de uso. A partir disso, espera-se que o sistema imprima um relatório da receita ao paciente ou permita sua visualização via internet.

## Screenshots

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)

## Segunda parte

Considere a seguinte descrição e o diagrama ER abaixo:

No hospital, as internações têm sido registradas por meio de formulários eletrônicos que gravam os dados em arquivos. 

Para cada internação, são anotadas a data de entrada, a data prevista de alta e a data efetiva de alta, além da descrição textual dos procedimentos a serem realizados. 

As internações precisam ser vinculadas a quartos, com a numeração e o tipo. 

Cada tipo de quarto tem sua descrição e o seu valor diário (a princípio, o hospital trabalha com apartamentos, quartos duplos e enfermaria).

Também é necessário controlar quais profissionais de enfermaria estarão responsáveis por acompanhar o paciente durante sua internação. Para cada enfermeiro(a), é necessário nome, CPF e registro no conselho de enfermagem (CRE).

A internação, obviamente, é vinculada a um paciente – que pode se internar mais de uma vez no hospital – e a um único médico responsável.

## Screenshots

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)

Faça a ligação do diagrama acima ao diagrama desenvolvido na atividade antrior, construindo relacionamentos com entidades relacionadas. E eleve o seu diagrama para que já selecionando os tipos de dados que serão trabalhados e em quais situações. 

Por último, crie um script SQL para a geração do banco de dados e para instruções de montagem de cada uma das entidades/tabelas presentes no diagrama completo (considerando as entidades do diagrama da atividade anterior e as novas entidades propostas no diagrama acima). Também crie tabelas para relacionamentos quando necessário. Aplique colunas e chaves primárias e estrangeiras.

 ```mysql
CREATE TABLE `Medicos` (
  `id` int PRIMARY KEY,
  `nome` varchar(255),
  `cpf` varchar(255),
  `rg` varchar(255),
  `endereco` varchar(255),
  `telefone` varchar(255),
  `email` varchar(255)
);

CREATE TABLE `Especialidades` (
  `id` int PRIMARY KEY,
  `nome` varchar(255)
);

CREATE TABLE `Medicos_Especialidades` (
  `medico_id` int,
  `especialidade_id` int,
  PRIMARY KEY (`medico_id`, `especialidade_id`),
  FOREIGN KEY (`medico_id`) REFERENCES `Medicos` (`id`),
  FOREIGN KEY (`especialidade_id`) REFERENCES `Especialidades` (`id`)
);

CREATE TABLE `Pacientes` (
  `id` int PRIMARY KEY,
  `nome` varchar(255),
  `data_nascimento` date,
  `endereco` varchar(255),
  `telefone` varchar(255),
  `email` varchar(255),
  `cpf` varchar(255),
  `rg` varchar(255),
  `convenio_id` int
);

CREATE TABLE `Convenios` (
  `id` int PRIMARY KEY,
  `nome` varchar(255),
  `cnpj` varchar(255),
  `tempo_carencia` int
);

CREATE TABLE `Consultas` (
  `id` int PRIMARY KEY,
  `data` date,
  `hora` time,
  `medico_id` int,
  `paciente_id` int,
  `valor_consulta` decimal,
  `convenio_nome` varchar(255),
  `numero_carteira` varchar(255),
  `especialidade_id` int
);

CREATE TABLE `Receitas` (
  `id` int PRIMARY KEY,
  `consulta_id` int,
  `medicamento` varchar(255),
  `quantidade` int,
  `instrucoes` varchar(255)
);

CREATE TABLE `Quartos` (
  `numeracao` int PRIMARY KEY,
  `tipo` int,
  `descricao` varchar(255),
  `valor_da_diaria` float
);

CREATE TABLE `Profissional_enf` (
  `id` int PRIMARY KEY,
  `nome` varchar(255),
  `cpf` varchar(255),
  `registro_do_conselho` varchar(255)
);

CREATE TABLE `Internacao` (
  `id` int PRIMARY KEY,
  `data_de_entrada` date,
  `data_prevista_alta` date,
  `data_efetiva_alta` date,
  `procedimentos` varchar(255),
  `paciente_id` int,
  `medico_id` int,
  `quarto_numeracao` int
);

ALTER TABLE `Medicos_Especialidades` ADD FOREIGN KEY (`medico_id`) REFERENCES `Medicos` (`id`);

ALTER TABLE `Medicos_Especialidades` ADD FOREIGN KEY (`especialidade_id`) REFERENCES `Especialidades` (`id`);

ALTER TABLE `Pacientes` ADD FOREIGN KEY (`convenio_id`) REFERENCES `Convenios` (`id`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`medico_id`) REFERENCES `Medicos` (`id`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`paciente_id`) REFERENCES `Pacientes` (`id`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`especialidade_id`) REFERENCES `Especialidades` (`id`);

ALTER TABLE `Receitas` ADD FOREIGN KEY (`consulta_id`) REFERENCES `Consultas` (`id`);

ALTER TABLE `Internacao` ADD FOREIGN KEY (`paciente_id`) REFERENCES `Pacientes` (`id`);

ALTER TABLE `Internacao` ADD FOREIGN KEY (`medico_id`) REFERENCES `Medicos` (`id`);

ALTER TABLE `Internacao` ADD FOREIGN KEY (`quarto_numeracao`) REFERENCES `Quartos` (`numeracao`);

 ```
