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