-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 29, 2022 alle 11:10
-- Versione del server: 10.4.24-MariaDB
-- Versione PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hw2`
--
CREATE DATABASE IF NOT EXISTS `hw2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hw2`;

-- --------------------------------------------------------

--
-- Struttura della tabella `carrello`
--

CREATE TABLE `carrello` (
  `ID` int(11) NOT NULL,
  `proprietario` varchar(20) NOT NULL,
  `Totale` float DEFAULT 0,
  `Nome` varchar(255) DEFAULT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `likes` int(11) DEFAULT 0,
  `data` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `carrello`
--

INSERT INTO `carrello` (`ID`, `proprietario`, `Totale`, `Nome`, `Descrizione`, `likes`, `data`) VALUES
(1, 'admin', 0, NULL, NULL, 0, '2022-05-24 18:39:45'),
(2, 'root', 0, NULL, NULL, 0, '2022-05-24 18:40:12'),
(3, 'root', 331.12, 'Arduino kit', 'Un insieme di arduini e kit vari', 1, '2022-05-24 18:45:32'),
(4, 'root', 5588.15, 'Carrello casuale', 'Carrello fatto per prova', 1, '2022-05-24 18:55:42'),
(5, 'admin', 1927.91, 'Computer a poco', 'Computer casuali', 1, '2022-05-24 19:05:09');

--
-- Trigger `carrello`
--
DELIMITER $$
CREATE TRIGGER `newid` BEFORE INSERT ON `carrello` FOR EACH ROW BEGIN

if ((SELECT max(id) FROM `carrello`) >0) THEN
	SET new.id=(SELECT (max(id)+1) FROM `carrello`);
ELSE
	set new.id=1;
end IF;


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `commenti`
--

CREATE TABLE `commenti` (
  `mittente` varchar(20) NOT NULL,
  `carrello` int(11) NOT NULL,
  `commento` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `commenti`
--

INSERT INTO `commenti` (`mittente`, `carrello`, `commento`, `id`) VALUES
('root', 3, 'Davvero dei bei kit', 22),
('admin', 5, 'commento casuale', 29);

-- --------------------------------------------------------

--
-- Struttura della tabella `piaciuti`
--

CREATE TABLE `piaciuti` (
  `mittente` varchar(20) NOT NULL,
  `carrello` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `piaciuti`
--

INSERT INTO `piaciuti` (`mittente`, `carrello`) VALUES
('admin', 4),
('admin', 5),
('root', 3);

--
-- Trigger `piaciuti`
--
DELIMITER $$
CREATE TRIGGER `aggiungiLike` AFTER INSERT ON `piaciuti` FOR EACH ROW BEGIN
UPDATE carrello
SET likes = likes+1
WHERE ID=new.carrello;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sottraiLike` BEFORE DELETE ON `piaciuti` FOR EACH ROW BEGIN
UPDATE carrello
SET likes = likes-1
WHERE ID=old.carrello;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotti`
--

CREATE TABLE `prodotti` (
  `url` varchar(500) NOT NULL,
  `Venditore` varchar(255) NOT NULL,
  `titolo` varchar(255) NOT NULL,
  `prezzo` float NOT NULL,
  `UrlImg` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `prodotti`
--

INSERT INTO `prodotti` (`url`, `Venditore`, `titolo`, `prezzo`, `UrlImg`) VALUES
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002836546742.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle%2526memo1%253Dfreelisting&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QgOUECK4I&usg=AOvVaw1i35D1UQkA3g9cDqQ0jeR0', 'AliExpress.com', 'Arduino UNO R3 Starter Kit DIY MCU control scheda di programmazione ATMEGA328P ...', 8.09, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQI0rY5WlUCahWRhTAQ8vt86hTetUavQ2513QV5rMWZa7WISD9P9pzqQhJtRIZN7iS4JkuTrq-gzqUD8WvdTZl6RrWnmbAUeZC30xk3qRhjuCyhCGHBWPHV&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003117768294.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QgOUECLkI&usg=AOvVaw1ZAvoe09qa0Oo7ZB2SFnu3', 'AliExpress.com', 'UNO R3 MEGA328P CH340 CH340G ATMEGA16U2   Chip MEGA328P per scheda di sviluppo ...', 0.74, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQ2VFTF_fjxXgRYFFfJs4UglztI_YNq99GwfvODLfH7eKr7CcHcEeiy3I5sXTV8e4QXr6Xu0cyBxdS4lhhrNz0sP-bRFWJz6KH6zjU3st8GeyY8tTnNqs9L0Q&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003249588186.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECPwH&usg=AOvVaw1sc3fD69X3VC8LqSxWxLVo', 'AliExpress.com', 'PC da gioco AMD 6-Core R5 3600 RTX3060 12G DDR4 16G RAM 500G M.2 computer Desktop ...', 113.26, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTU8mnkHCsfFFPjWrTr7akty-UVRO-eGRllDF18AFdFknWeaV5E9oYmRo5tLvQVmxKf-80tQZcUmbZJ0bk1m8SG9ShDyQwV6qGBuRgL94G4ZGzcFWq-sfT1vg&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003343122908.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QgOUECN4I&usg=AOvVaw3ADf2o2Frx5kWnVaUvAJlH', 'AliExpress.com', 'Scheda di sviluppo ATmega328P-PU ATMEGA16U2 MEGA16U2 16U2 per Arduino UNO R3 con ...', 1.61, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQGqLH63GPWiswxMKDJiO7DyUI_lnWmmJH3lnJWsji5vMlmZiagIe69udgI_bRAAChpmKc-m8jILOzFRTpO1-apBBZBnKaGTeT7koJEjpnpRwzAv1Io1-_vXA&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003891928734.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QgOUECPYI&usg=AOvVaw2bnIb1Cm_dP6MLyzaKPNuh', 'AliExpress.com', 'Per Arduino Shield Ethernet Shield W5100 R3 UNO Mega 2560 1280 328 MEGA328P ...', 0.4, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTbYj_xneO-lRHaHBnBirgn78Zlk7eWC7RztkTVL2WmbsK0aupG99nhzIDp-C7WJCStZ81aCuB9EAAyH16Bm1b73v3MFjDZXIn2Xra9fmdsWT_nvsZT6pSz&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004144813439.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECJMI&usg=AOvVaw0Bf-YMYQm5oDRqgxMJKFIe', 'AliExpress.com', 'Set di Computer computerador pc Gamer Core i5 CPU DDR4 8/16GB SSD Gaming Pc ...', 113.26, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS7c3jYK1tEbeLgmV2rjW06F00e8nFPQo4n2CIvgspR6eoHo_8AbuaL4szUa1dT-wOo_GQjrlDfDoJ2asj74xosb90A-nJ4SXUEsCgFwufYopL4HgBxIGG5&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004187839724.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECKoI&usg=AOvVaw3i8sgHWi0noG6IOOPggjAW', 'AliExpress.com', 'OEM CPU I7 Core host computer ad alte prestazioni in vendita', 482.51, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQu4kXPVSn4efWVJplvQ8Z8jr_BzLIYFd6QJENaybZteWtExlUFi-MxQ-Dc8c4kJ5NqBZvblPda3QipC6YyCCZWxp-wc_uh4UO6x7iVxrQcOVPjas2rjWvX&usqp=CAE'),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-mega-2560-rev3%3Fsrsltid%3DAWLEVJx0n2E2csNqZ9OIr3fcYAb2NF5BooRjPzpZJkMpBAj8pa7XJD3daJQ&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QguUECKII&usg=AOvVaw1PYMCWvKVjiGMuVMCPTW5D', 'Arduino Official Store', 'Arduino Scheda Mega 2560 A000067', 35, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTdeQJeaLlmPcwWN7MJTIU8MmC2LkbhoX04Tf1zKfVMGvMskmqilsnXSVOkfaiIiFsNvx4rX04RDa10PLe6c2d_8NKKU4XcWOqP90DkyGrSNwHKNNf8-F7bQw&usqp=CAE'),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3-smd%3Fsrsltid%3DAWLEVJyG-MsPV9A0kpM56COQIszQ4OTxXb4ZbW2dr2QY0rEPZD-bvGlyTMk&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QguUECNII&usg=AOvVaw3-AnaAxwYG2WktHgzjd0N9', 'Arduino Official Store', 'Arduino Uno REV3 SMD', 19, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTMXxMQW8i2w5YpJalnnFoUfSBUN7H5Phq_5CWkA1xqotuIQUID9EeO4xsMbEn0m-ddy6hwd66X16aAHxB0pDqWuKSLn_PSx8gl1p7JyBYdMwAC34zVavso&usqp=CAE'),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3/%3Fsrsltid%3DAWLEVJxInUPL436aIPwGR3ZPE0xW_J5lSGY_50_Tk08ByvniP1JSCN6JZ8Q&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QguUECMUI&usg=AOvVaw0G7YQVouaPAGAe7oOUcM3y', 'Arduino Official Store', 'Arduino Uno REV3 [A000066]', 20, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTNFj5ahb2rljsQ-3kygftelnUWcb98qFTvR6ZsoSoKEnyIkBa55c1zen20Fvc2Ckq1uNTwcG8F5q_iJU6jk1i48EsRKRdnNaI7buJvrK6x&usqp=CAE'),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-wifi-rev2%3Fsrsltid%3DAWLEVJz5S-mDS5t7FXw9r72N8Y7ZZEZBGbwI9VGNU2V_eWwe4nkf_z6dyrY&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QguUECOoI&usg=AOvVaw0ok7wyBFF4MRJga57zhoWh', 'Arduino Official Store', 'Arduino Uno Wifi REV2', 38.9, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcREbKq6rUfsQiqJSjO4zvaUmYbUUykQzfJ2EwwaJNrzCGXg1DXfK48a-GP6KgLVI4Ze8yrY8bXeqoU00ZelGOzBTTbt39Scno5Znt6zsKCHQTVuNTT0rGI2NA&usqp=CAE'),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi94di00Pj3AhU0p3IEHbV1AtoQgOUECLwI&usg=AOvVaw0zR_DycBM3kYkL-YHUf3wa', 'Tutto Cantiere Online', 'Dispositivo di salvataggio ed evacuazione   sacco TC013', 1450, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ3hHJvoLRip-SEYqcxd-bgafL_MJbOj60HI4WYZkHiwkxbsFPWKfaasc1Z1dQCZTampLiYrs9FHtKP6ByVXsbCcXSgNqy6fCRdKgMDWSOC1e6lzIHfhJ7Z&usqp=CAE'),
('https://www.google.it/url?url=https://www.auto-doc.it/cartrend/16163871&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECN4J&usg=AOvVaw0dqzdCVatb4DwUiijyl40Q', 'Auto-doc.it', 'Cartrend 10646 Set di 2 Rampe in Plastica per Auto, moto, Sedia a rotelle,', 41.58, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQGPEDfm2_obu89LrYI4UEMKn-ZaAgqm4NSlrXH0R0RQzZJgkZJxb-OwgDXrCreouzB8tyELeVwKEBomKaNR0M4DF5rJFCGTIZkWZl2cIqBsNA5F9IR_khvUA&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-bambino-lj100n-easy-arancione-grigio/_/R-p-311034%3Fmc%3D8569209%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi94di00Pj3AhU0p3IEHbV1AtoQ_uQECLAI&usg=AOvVaw3gv9-1-4_WzE0MQKFPNyCL', 'Decathlon', 'Tribord. Giubbotto salvataggio Bambino Lj100n Easy Arancione-Grigio', 24.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRecHhuG2HD5wGeMxmLQnaFdQEpbcZMBwF3zGICpafJsnjZ0U-aOd5jSYegRjsuvdlHzPzWXVhQIRmiUETYn2mwE9Jpvf3xHvh5niULOs8Ar1ClEtQd2i1L&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi94di00Pj3AhU0p3IEHbV1AtoQ_uQECJEI&usg=AOvVaw1R8QJoVoD7m8drfUYLh3pf', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://www.ebay.it/itm/313983878485%3Fvar%3D0&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECMUJ&usg=AOvVaw20O3_J5wFrGLr2OXuUC-Sz', 'eBay.it', 'Auto Set', 715.6, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRwKrhmzfMbyzvbD0yQiUHauCVmCpv-8FK_W1k01hzFNx9gL9Cbx_ng7fnbTln6PCthm39Z01Nty8EIiJdFIHBpNJv17gNpJRsr87nZqww&usqp=CAE'),
('https://www.google.it/url?url=https://www.ebay.it/itm/363733439849%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQguUECJ4I&usg=AOvVaw3rpSTFW_9iky8gP-JtmFUl', 'eBay - alberto_giordano', 'PC Computer ALL in One Topcore 24\" Core i5-3320M RAM 8GB SSD 480GB Windows 10', 399.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQmyQwBFSP8KUjhxBGXQhhC-ws8S78qHy6ACIEEDqCKelGr0IrCltES9fo2-4PIexyUluRm32C_XSWbF-BYFHzBHPMgU8KQmTlB2B-FlwxHICQmV_WkjRBB&usqp=CAE'),
('https://www.google.it/url?url=https://www.edilizia-valenti.com/prodotto/outlet-computer-outsider-pc-fisso-completo-intel-i5-ram-8gb-ssd-240-gb-monitor-24-pollici-tastiera-e-mouse-usb-casse-audio/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECPEH&usg=AOvVaw3vednmnw2N5gpgfw9Y4dPM', 'Edilizia-Valenti', 'Outlet computer outsider Pc fisso completo intel i5 ram 8gb - ssd 240 gb monitor ...', 49.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTov6WmGoFBJ9S9PrNV6MsB9kI2XbizibkH0JTbXJYM8wEcbtS_caQ6GSJMfdQNnGR4Iz0b234Bq2TSOw_YcMDa-xuVAvDYYx8XZCg-ty4&usqp=CAE'),
('https://www.google.it/url?url=https://www.edilizia-valenti.com/prodotto/pc-desktop-completo-intel-quadcore-2-00ghz-ssd-240gb-ram-8gb-computer-fisso-completo-monitor-24-full-hd/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECLUI&usg=AOvVaw2EzpJWRLQ48gACVAbwTBNJ', 'Edilizia-Valenti', 'Pc desktop completo intel quadcore 2.00ghz ssd 240gb ram 8gb computer fisso ...', 49.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRmyUcSqI9UYo1RdUgPRlxVdh-77TpFqBQ5ObQ3H5K71qyzl0OrNql9B2M-pB7dg0bl7A7oo6ydJI8mdb-Loodw-V6uqZLG6iysunEN4Ns&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1074133246/auto-usate%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECLoJ&usg=AOvVaw02imXCHfk1w7AvAzdEv8TV', 'Etsy - Seller', 'Auto usate', 177.69, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTsnwioWrCHlDlp_EBYAeazk9XuraG2sJM_iZ_RZmisUIAJXVcmwIKDsdzm5OyypYKRm1tJ6EPi5KkE87xvfIACBJO42Wth_xsyCkedt4Wj&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1204011417/auto%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECIoJ&usg=AOvVaw3loB_flv6W_k5ZjsDPPiPq', 'Etsy - luggagepro', 'auto', 789.73, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTAKRMC65KaWroUa9rk1P5BKpzXjBfd0O6e7ammSdV-OoQtlLatDCLq4dS77UQrwA7adBPOmnlshqdMC-1j49tDepr7NVFdI81aYXk6W6ID&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/806313717/vecchia-auto%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECJYJ&usg=AOvVaw1JFRE7e5YKWXkmpO8i1EVr', 'Etsy - DigiphotosByMichael', 'Vecchia auto', 12.04, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQKFxpQAxIqK4XZ5pUhJtiXiLscKr4Zv6GFyOe5hqS3zAmo7o5JdNtAuMEOXzsVSWRj1VMxGqTTXhNuRVW1VcTLcLG0Zea6tDXKw78o9F69&usqp=CAE'),
('https://www.google.it/url?url=https://www.gautoparts.it/it/prod/box-marathon-400-lt-dark-marathon400dark/1356598&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECOsJ&usg=AOvVaw3bHKjsGa37y39_9o1wEyFi', 'Gentile Antonio', 'Box baule tetto Auto Menabo Dark Nero Opaco Marathon 400 LT 165x79x37 Universale', 185.72, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRacHpugk0JPVQDIz8fh8SC4Ir9MVSzgxt8TBJm93E4i1Ajp63lsiT8yT4StoIG7uRiO6Td7VwfZM6KtbQqVJeE3JcXDCCcy_TdKWx0ziZ0oUUMpgGxy9JgLQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.ibs.it/pc-fisso-computer-i5-quad-informatica-nonsoloinformatica/e/8052679510115%3Flgw_code%3D1122-W8052679510115&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQguUECIcI&usg=AOvVaw1ERoEmQ1FEY0coFYMVKDTj', 'IBS.it', 'PC fisso Computer i5 Quad Core Windows 10 Pro 8GB RAM, SSD 240GB, HD 500GB, Wifi', 319.99, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRI7BqYbuHau0Uv2YJtYSnYnYnOMdFV2yjZl-xTpVhZCLBAVLNQUndP17wsjreiOy8o4OM-GlENncV8WLHn79OrUromCUqQkRsiXgNZBTPZ9X8a_SfN6htcow&usqp=CAE'),
('https://www.google.it/url?url=https://www.klavius.it/catalogo/prodotti/00TUF9212O%3Fsrsltid%3DAWLEVJzSLug0ZNtOmTHPP7FFyllA7pnWdTL45qyKh2H-Rr8bOflhZhYE5JE&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECPcJ&usg=AOvVaw1vSuKKkhRu-rmHbfA6xo02', 'Klavius.it', '2 pezzi Auto Sedile per Sedile Auto Backseat Custodia bambini Calci Fango', 16.9, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQAzISeZMOkvc3IVJOpUN6YZpytZZ0C6eIJFmo9zDdpYHBD5Ujmsc-Qjln83MHqNyLvcfFpf7mvc_vY1NKm8gNZuUj63rNY3qLneUazA7Y&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi94di00Pj3AhU0p3IEHbV1AtoQguUECJ8I&usg=AOvVaw3MLfOWRymuJ-Au2qRQRUS5', 'Muziker IT', 'Lalizas Giubbotto di salvataggio Chico 100N 15-30 kg', 29.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRG7BaCrsz0VuKDmRnGkskJxGcYLXFVtPOcEqxJ1aX0USx3NKujrOPvUoRHq80iqYGWJjKr6RviKJxkASjtmYRD5FqAhFrlYcwXoTPoBpXvSuUs6VpftUhV&usqp=CAE'),
('https://www.google.it/url?url=https://www.nonsoloinformatica.com/computer-pc-fisso-i7-quad-core-windows-10-pro-16gb-ram-ssd-240gb-hd-1tb-wifi/id/252642%26r%3Dgoogle-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQguUECOUH&usg=AOvVaw2JkveBGyT5lEAW1iGRfanW', 'Nonsoloinformatica', 'Computer PC fisso i7 Quad Core Windows 10 Pro 16GB RAM, SSD 240GB, HD 1TB, Wifi', 399.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRIbcJwh0tCH52K2zcnWMLHuzI2hYol7lWNI0wESlgApkbVUbrcb1RgDBcofuHjdVoUuWnJ7_zMxYJmcnOKuD0j2rTCMutVZto1yykcs3DaHS4C5KkrdeAqfA&usqp=CAE'),
('https://www.google.it/url?url=https://www.opendeel.com/product/cartrend-10904-rampa-per-auto-2t-1-pezzo-Iwz9xoABKN7S1C5hVAuN.html%3Ff%3Dgm&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECK4J&usg=AOvVaw3aE_iODhxDn1s-bBTaltHS', 'Opendeel', 'Cartrend 10904 Rampa per Auto 2T 1 Pezzo', 29.26, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTr_gP3UDGSbB8LLyvCT4tOiDxanUQyMSxgfJ_SD0-eQRcT1GALkeyKch3JjOhahUXgpCe3w5iO2-UlRoCK8cBlBq-WEyhr-MmkuKPnBS_95706rhNdKgGi&usqp=CAE'),
('https://www.google.it/url?url=https://www.ricambi-smc.it/ricambi-auto/prodotti/batteria-auto-speed-max-75ah-680a-12v-l3b/1097478&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECKEJ&usg=AOvVaw3flrTmO36_9wWSZJ_CThaT', 'Ricambi Auto SMC', 'Batteria Auto Speed Max L4100 100Ah 850A 12V = FIAMM 100Ah DX  Pronta ALL\'USO', 62.61, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTlinme9lF0T-ZvJgNabu3P4oQGhw4KRIo534NGJC221xxy4LtH_KXRpJxayHjisENMuEnNCb6kkxLifny0fEgdG8flXOebpaphcKW55CFN267vc7MymCnH&usqp=CAE'),
('https://www.google.it/url?url=https://www.stampaestampe.it/adesivi-per-auto-p-315.html%3Flink_created%3D1%26qnt%3D1%26quantita%3D1%26data%3D10%26m%3D316%26misura%3D16%26%3D%26srsltid%3DAWLEVJwWC1NylAAgVdFV1w_WjPjeqNtehzVShOZIqPAWKL_UMvemBE7I4Jg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECNIJ&usg=AOvVaw1s1WEu-XYlu-hY6iYGvKHh', 'StampaeStampe', 'Stampa Adesivi Auto e Moto personalizzati in HD', 20.6, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRzOItSz96wBUAnKE9NpC5wLn1LvalOR05p_XPjFeCQFmh_KPRO6HWN8UxG8H5LQ5lYXvTMxpAqUQLfbk2FFkkhOjg3w_YSmWn-OGRX0xWdxT0r9potIRWLOg&usqp=CAE');

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotto-carrello`
--

CREATE TABLE `prodotto-carrello` (
  `prodotto` varchar(500) NOT NULL,
  `carrello` int(11) NOT NULL,
  `quantita` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `prodotto-carrello`
--

INSERT INTO `prodotto-carrello` (`prodotto`, `carrello`, `quantita`) VALUES
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002836546742.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle%2526memo1%253Dfreelisting&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QgOUECK4I&usg=AOvVaw1i35D1UQkA3g9cDqQ0jeR0', 3, 9),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003117768294.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QgOUECLkI&usg=AOvVaw1ZAvoe09qa0Oo7ZB2SFnu3', 3, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003249588186.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECPwH&usg=AOvVaw1sc3fD69X3VC8LqSxWxLVo', 5, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003343122908.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QgOUECN4I&usg=AOvVaw3ADf2o2Frx5kWnVaUvAJlH', 3, 7),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003891928734.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QgOUECPYI&usg=AOvVaw2bnIb1Cm_dP6MLyzaKPNuh', 3, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004144813439.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECJMI&usg=AOvVaw0Bf-YMYQm5oDRqgxMJKFIe', 5, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004187839724.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECKoI&usg=AOvVaw3i8sgHWi0noG6IOOPggjAW', 5, 1),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-mega-2560-rev3%3Fsrsltid%3DAWLEVJx0n2E2csNqZ9OIr3fcYAb2NF5BooRjPzpZJkMpBAj8pa7XJD3daJQ&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QguUECKII&usg=AOvVaw1PYMCWvKVjiGMuVMCPTW5D', 3, 1),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3-smd%3Fsrsltid%3DAWLEVJyG-MsPV9A0kpM56COQIszQ4OTxXb4ZbW2dr2QY0rEPZD-bvGlyTMk&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QguUECNII&usg=AOvVaw3-AnaAxwYG2WktHgzjd0N9', 3, 8),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3/%3Fsrsltid%3DAWLEVJxInUPL436aIPwGR3ZPE0xW_J5lSGY_50_Tk08ByvniP1JSCN6JZ8Q&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QguUECMUI&usg=AOvVaw0G7YQVouaPAGAe7oOUcM3y', 3, 1),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-wifi-rev2%3Fsrsltid%3DAWLEVJz5S-mDS5t7FXw9r72N8Y7ZZEZBGbwI9VGNU2V_eWwe4nkf_z6dyrY&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj1oe_ku_j3AhXMKkQIHXogDZ8QguUECOoI&usg=AOvVaw0ok7wyBFF4MRJga57zhoWh', 3, 1),
('https://www.google.it/url?url=https://www.ebay.it/itm/313983878485%3Fvar%3D0&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECMUJ&usg=AOvVaw20O3_J5wFrGLr2OXuUC-Sz', 4, 6),
('https://www.google.it/url?url=https://www.ebay.it/itm/363733439849%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQguUECJ4I&usg=AOvVaw3rpSTFW_9iky8gP-JtmFUl', 5, 1),
('https://www.google.it/url?url=https://www.edilizia-valenti.com/prodotto/outlet-computer-outsider-pc-fisso-completo-intel-i5-ram-8gb-ssd-240-gb-monitor-24-pollici-tastiera-e-mouse-usb-casse-audio/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECPEH&usg=AOvVaw3vednmnw2N5gpgfw9Y4dPM', 5, 1),
('https://www.google.it/url?url=https://www.edilizia-valenti.com/prodotto/pc-desktop-completo-intel-quadcore-2-00ghz-ssd-240gb-ram-8gb-computer-fisso-completo-monitor-24-full-hd/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQgOUECLUI&usg=AOvVaw2EzpJWRLQ48gACVAbwTBNJ', 5, 1),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1074133246/auto-usate%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECLoJ&usg=AOvVaw02imXCHfk1w7AvAzdEv8TV', 4, 1),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1204011417/auto%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECIoJ&usg=AOvVaw3loB_flv6W_k5ZjsDPPiPq', 4, 1),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/806313717/vecchia-auto%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECJYJ&usg=AOvVaw1JFRE7e5YKWXkmpO8i1EVr', 4, 1),
('https://www.google.it/url?url=https://www.gautoparts.it/it/prod/box-marathon-400-lt-dark-marathon400dark/1356598&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECOsJ&usg=AOvVaw3bHKjsGa37y39_9o1wEyFi', 4, 1),
('https://www.google.it/url?url=https://www.ibs.it/pc-fisso-computer-i5-quad-informatica-nonsoloinformatica/e/8052679510115%3Flgw_code%3D1122-W8052679510115&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQguUECIcI&usg=AOvVaw1ERoEmQ1FEY0coFYMVKDTj', 5, 1),
('https://www.google.it/url?url=https://www.klavius.it/catalogo/prodotti/00TUF9212O%3Fsrsltid%3DAWLEVJzSLug0ZNtOmTHPP7FFyllA7pnWdTL45qyKh2H-Rr8bOflhZhYE5JE&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECPcJ&usg=AOvVaw1vSuKKkhRu-rmHbfA6xo02', 4, 1),
('https://www.google.it/url?url=https://www.nonsoloinformatica.com/computer-pc-fisso-i7-quad-core-windows-10-pro-16gb-ram-ssd-240gb-hd-1tb-wifi/id/252642%26r%3Dgoogle-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiU8oHnzvj3AhVIhHIEHfpZA_IQguUECOUH&usg=AOvVaw2JkveBGyT5lEAW1iGRfanW', 5, 1),
('https://www.google.it/url?url=https://www.opendeel.com/product/cartrend-10904-rampa-per-auto-2t-1-pezzo-Iwz9xoABKN7S1C5hVAuN.html%3Ff%3Dgm&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECK4J&usg=AOvVaw3aE_iODhxDn1s-bBTaltHS', 4, 1),
('https://www.google.it/url?url=https://www.ricambi-smc.it/ricambi-auto/prodotti/batteria-auto-speed-max-75ah-680a-12v-l3b/1097478&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QguUECKEJ&usg=AOvVaw3flrTmO36_9wWSZJ_CThaT', 4, 1),
('https://www.google.it/url?url=https://www.stampaestampe.it/adesivi-per-auto-p-315.html%3Flink_created%3D1%26qnt%3D1%26quantita%3D1%26data%3D10%26m%3D316%26misura%3D16%26%3D%26srsltid%3DAWLEVJwWC1NylAAgVdFV1w_WjPjeqNtehzVShOZIqPAWKL_UMvemBE7I4Jg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwig1ZWDzfj3AhXfj3IEHYSgBp4QgOUECNIJ&usg=AOvVaw1s1WEu-XYlu-hY6iYGvKHh', 4, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `profilo`
--

CREATE TABLE `profilo` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `ImmagineProfilo` varchar(255) DEFAULT NULL,
  `carrelloCorrente` int(11) DEFAULT 0,
  `seguaci` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `profilo`
--

INSERT INTO `profilo` (`Username`, `Password`, `Email`, `ImmagineProfilo`, `carrelloCorrente`, `seguaci`) VALUES
('admin', 'admin1', 'admin@admin.com', 'upload/admin.gif', 1, 1),
('root', 'root1', 'root@root.it', NULL, 2, 1);

--
-- Trigger `profilo`
--
DELIMITER $$
CREATE TRIGGER `creaCarrello` AFTER INSERT ON `profilo` FOR EACH ROW BEGIN
if ((SELECT max(id) FROM `carrello`) >0) THEN
INSERT INTO `carrello`  (ID,proprietario)
SELECT (max(id)+1),new.Username FROM `carrello`;
ELSE
	INSERT INTO `carrello` ( id,`proprietario`, `Totale`, `Nome`, `Descrizione`, `likes`) 
 VALUES
(1,new.Username, '0', NULL, NULL, '0');
end IF;



END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `numeroCarrello` BEFORE INSERT ON `profilo` FOR EACH ROW BEGIN

if ((SELECT max(id) FROM `carrello`) >0) THEN
	SET new.carrelloCorrente=(SELECT (max(id)+1) FROM `carrello`);
ELSE
	set new.carrelloCorrente=1;
end IF;


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `segui`
--

CREATE TABLE `segui` (
  `seguace` varchar(20) NOT NULL,
  `seguito` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `segui`
--

INSERT INTO `segui` (`seguace`, `seguito`) VALUES
('admin', 'root'),
('root', 'admin');

--
-- Trigger `segui`
--
DELIMITER $$
CREATE TRIGGER `aggiungiFollower` AFTER INSERT ON `segui` FOR EACH ROW BEGIN
UPDATE profilo
SET seguaci = seguaci+1
WHERE Username=new.seguito;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sottraiFollower` BEFORE DELETE ON `segui` FOR EACH ROW BEGIN
UPDATE profilo
SET seguaci = seguaci-1
WHERE Username=old.seguito;
END
$$
DELIMITER ;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `carrello`
--
ALTER TABLE `carrello`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `proprietario` (`proprietario`);

--
-- Indici per le tabelle `commenti`
--
ALTER TABLE `commenti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commenti_ibfk_1` (`mittente`);

--
-- Indici per le tabelle `piaciuti`
--
ALTER TABLE `piaciuti`
  ADD PRIMARY KEY (`mittente`,`carrello`);

--
-- Indici per le tabelle `prodotti`
--
ALTER TABLE `prodotti`
  ADD PRIMARY KEY (`url`);

--
-- Indici per le tabelle `prodotto-carrello`
--
ALTER TABLE `prodotto-carrello`
  ADD PRIMARY KEY (`prodotto`,`carrello`),
  ADD KEY `carrello` (`carrello`);

--
-- Indici per le tabelle `profilo`
--
ALTER TABLE `profilo`
  ADD PRIMARY KEY (`Username`),
  ADD UNIQUE KEY `ind_email` (`Email`);

--
-- Indici per le tabelle `segui`
--
ALTER TABLE `segui`
  ADD PRIMARY KEY (`seguace`,`seguito`),
  ADD KEY `seguito` (`seguito`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `commenti`
--
ALTER TABLE `commenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `carrello`
--
ALTER TABLE `carrello`
  ADD CONSTRAINT `carrello_ibfk_1` FOREIGN KEY (`proprietario`) REFERENCES `profilo` (`Username`);

--
-- Limiti per la tabella `commenti`
--
ALTER TABLE `commenti`
  ADD CONSTRAINT `commenti_ibfk_1` FOREIGN KEY (`mittente`) REFERENCES `profilo` (`Username`);
ALTER TABLE `commenti`
  ADD CONSTRAINT `commenti` FOREIGN KEY (`carrello`) REFERENCES `carrello` (`ID`) ON DELETE CASCADE;

--
-- Limiti per la tabella `piaciuti`
--
ALTER TABLE `piaciuti`
  ADD CONSTRAINT `piaciuti_ibfk_1` FOREIGN KEY (`mittente`) REFERENCES `profilo` (`Username`) ON DELETE CASCADE;
ALTER TABLE `piaciuti`
  ADD CONSTRAINT `piaciuti` FOREIGN KEY (`carrello`) REFERENCES `carrello` (`ID`) ON DELETE CASCADE;

--
-- Limiti per la tabella `prodotto-carrello`
--
ALTER TABLE `prodotto-carrello`
  ADD CONSTRAINT `prodotto-carrello_ibfk_1` FOREIGN KEY (`carrello`) REFERENCES `carrello` (`ID`);

--
-- Limiti per la tabella `segui`
--
ALTER TABLE `segui`
  ADD CONSTRAINT `segui_ibfk_1` FOREIGN KEY (`seguace`) REFERENCES `profilo` (`Username`),
  ADD CONSTRAINT `segui_ibfk_2` FOREIGN KEY (`seguito`) REFERENCES `profilo` (`Username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
