-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 05-Nov-2020 às 03:00
-- Versão do servidor: 10.1.37-MariaDB
-- versão do PHP: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pedidosvenda`
--
CREATE DATABASE IF NOT EXISTS `pedidosvenda` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `pedidosvenda`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `cidade` varchar(60) NOT NULL,
  `uf` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES
(1, 'Cliente Teste 01', 'São Paulo', 'SP'),
(2, 'Cliente Teste 02', 'Rio de Janeiro', 'RJ'),
(3, 'Cliente Teste 03', 'Porto Alegre', 'RS'),
(4, 'Cliente Teste 04', 'Florianópolis', 'SC'),
(5, 'Cliente Teste 05', 'Belo Horizonte', 'MG'),
(6, 'Cliente Teste 06', 'Brasília', 'DF'),
(7, 'Cliente Teste 07', 'Rio Branco', 'AC'),
(8, 'Cliente Teste 08', 'Maceió', 'AL'),
(9, 'Cliente Teste 09', 'Macapá', 'AP'),
(10, 'Cliente Teste 10', 'Manaus', 'AM'),
(11, 'Cliente Teste 11', 'Salvador', 'BA'),
(12, 'Cliente Teste 12', 'Fortaleza', 'CE'),
(13, 'Cliente Teste 13', 'Vitória', 'ES'),
(14, 'Cliente Teste 14', 'Goiânia', 'GO'),
(15, 'Cliente Teste 15', 'São Luís', 'MA'),
(16, 'Cliente Teste 16', 'Cuiabá', 'MT'),
(17, 'Cliente Teste 17', 'Campo Grande', 'MS'),
(18, 'Cliente Teste 18', 'Belém', 'PA'),
(19, 'Cliente Teste 19', 'João Pessoa', 'PB'),
(20, 'Cliente Teste 20', 'Curitiba', 'PR');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `codigo` int(11) NOT NULL,
  `codcliente` int(11) NOT NULL,
  `dataemissao` datetime NOT NULL,
  `valortotal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidosprodutos`
--

CREATE TABLE `pedidosprodutos` (
  `codigo` int(11) NOT NULL,
  `codpedido` int(11) NOT NULL,
  `codproduto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valorunitario` float NOT NULL,
  `valortotal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `codigo` int(11) NOT NULL,
  `descricao` varchar(150) NOT NULL,
  `precovenda` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`codigo`, `descricao`, `precovenda`) VALUES
(1, 'Mouse', '10.11'),
(2, 'Teclado', '11.12'),
(3, 'Cartão de memória', '12.13'),
(4, 'Pendrive', '13.14'),
(5, 'Cartucho de tinta', '14.15'),
(6, 'Filtro de linha', '15.16'),
(7, 'Switch', '16.17'),
(8, 'Telefone', '17.18'),
(9, 'Roteador', '18.19'),
(10, 'Projetor', '20.21'),
(11, 'Monitor', '21.22'),
(12, 'Televisão', '22.23'),
(13, 'Chave de fenda', '23.24'),
(14, 'Chave Philips', '24.25'),
(15, 'Chave de precisão', '25.26'),
(16, 'Alicate de bico', '26.27'),
(17, 'Alicate de pressão', '27.28'),
(18, 'Alicate de crimpar', '28.29'),
(19, 'Alicate de inserção', '30.31'),
(20, 'Caneta', '31.32');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `pedidosprodutos`
--
ALTER TABLE `pedidosprodutos`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codpedido` (`codpedido`),
  ADD KEY `codprodutos` (`codproduto`);

--
-- Indexes for table `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`codigo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pedidosprodutos`
--
ALTER TABLE `pedidosprodutos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produtos`
--
ALTER TABLE `produtos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `codcliente` FOREIGN KEY (`codigo`) REFERENCES `clientes` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `pedidosprodutos`
--
ALTER TABLE `pedidosprodutos`
  ADD CONSTRAINT `codpedido` FOREIGN KEY (`codpedido`) REFERENCES `pedidos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `codprodutos` FOREIGN KEY (`codproduto`) REFERENCES `produtos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
