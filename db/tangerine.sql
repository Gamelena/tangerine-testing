-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 17-04-2016 a las 16:50:38
-- Versión del servidor: 5.5.47-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `tangerine_testing`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_actions`
--

DROP TABLE IF EXISTS `acl_actions`;
CREATE TABLE IF NOT EXISTS `acl_actions` (
  `id` varchar(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `acl_actions`
--

INSERT INTO `acl_actions` (`id`, `title`) VALUES
('ADD', 'Agregar'),
('DELETE', 'Eliminar'),
('EDIT', 'Editar'),
('LIST', 'Listar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_groups`
--

DROP TABLE IF EXISTS `acl_groups`;
CREATE TABLE IF NOT EXISTS `acl_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `approved` enum('0','1') DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_groups_modules_actions`
--

DROP TABLE IF EXISTS `acl_groups_modules_actions`;
CREATE TABLE IF NOT EXISTS `acl_groups_modules_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acl_modules_actions_id` int(10) NOT NULL,
  `acl_groups_id` int(11) NOT NULL,
  `acl_modules_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_modules_actions_id` (`acl_modules_actions_id`,`acl_groups_id`,`acl_modules_item_id`),
  KEY `fk_acl_groups_modules_actions_acl_modules_actions1` (`acl_modules_actions_id`),
  KEY `fk_acl_groups_modules_actions_acl_groups1` (`acl_groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_modules`
--

DROP TABLE IF EXISTS `acl_modules`;
CREATE TABLE IF NOT EXISTS `acl_modules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Id de Módulo padre',
  `title` char(200) DEFAULT NULL COMMENT 'Nombre',
  `module` char(200) DEFAULT NULL COMMENT 'Url de módulo, puede ser archivo XML, URl de controlador o módulo ZF',
  `tree` enum('0','1') NOT NULL DEFAULT '1',
  `refresh_on_load` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Define si módulo debe ser refrescado al reseleccionar la pestaña, en caso contrario mantendrá el estatus de como se dejó al abandonarla.',
  `type` enum('xml','zend_module','legacy','iframe') DEFAULT 'xml',
  `approved` enum('0','1') NOT NULL DEFAULT '1',
  `order` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'Orden en que aparece en arbol',
  `root` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Define si solo puede acceder perfil ROOT (en configuracion por defecto acl_roles_id = 1)',
  `ownership` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Indica si modulo usa modelo con reglas de owner, funciona con type=xml, ver Zwei_Db_Table::isOwner(item, user)',
  `icons_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `module` (`module`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `acl_modules`
--

INSERT INTO `acl_modules` (`id`, `parent_id`, `title`, `module`, `tree`, `refresh_on_load`, `type`, `approved`, `order`, `root`, `ownership`, `icons_id`) VALUES
(1, NULL, 'Configuraci&oacute;n', NULL, '1', '0', NULL, '1', 11, '0', '0', 12),
(2, NULL, 'Tests', NULL, '1', '0', NULL, '1', 6, '0', '0', 25),
(3, NULL, 'Datos Personales', 'personal-info.xml', '0', '0', 'xml', '1', 0, '0', '0', NULL),
(4, 11, 'M&oacute;dulos', 'modules.xml', '1', '0', 'xml', '1', 1, '1', '0', 6),
(5, 10, 'Usuarios', 'users.xml', '1', '0', 'xml', '1', 1, '0', '0', 17),
(6, 10, 'Permisos', 'permissions.xml', '0', '0', 'xml', '0', 3, '1', '0', 0),
(7, 11, 'Servidor', 'phpinfo.xml', '1', '0', 'xml', '1', 6, '1', '0', 22),
(8, 10, 'Perfiles', 'roles.xml', '1', '0', 'xml', '1', 2, '1', '0', 7),
(9, 11, 'Configuraci&oacute;n Global', 'settings.xml', '1', '0', 'xml', '1', 5, '1', '0', 20),
(10, 1, 'Perfilamiento', NULL, '1', '0', NULL, '1', 1, '0', '0', 5),
(11, 1, 'Sitio', NULL, '1', '0', NULL, '1', 2, '0', '0', 13),
(12, 11, '&Iacute;conos', 'icons.xml', '1', '0', 'xml', '1', 7, '1', '0', 16),
(13, 9, 'Avanzado', 'settings-advanced.xml', '1', '0', 'xml', '1', 0, '1', '0', 21),
(14, 2, 'Carga masiva CSV', 'abonados.xml', '1', '0', 'xml', '1', 1, '0', '0', 17),
(15, 2, 'Gr&aacute;fico Tr&aacute;fico', 'graphic-traffic.xml', '1', '0', 'xml', '1', 2, '0', '0', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_modules_actions`
--

DROP TABLE IF EXISTS `acl_modules_actions`;
CREATE TABLE IF NOT EXISTS `acl_modules_actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acl_modules_id` int(11) NOT NULL,
  `acl_actions_id` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_modules_id` (`acl_modules_id`,`acl_actions_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=310 ;

--
-- Volcado de datos para la tabla `acl_modules_actions`
--

INSERT INTO `acl_modules_actions` (`id`, `acl_modules_id`, `acl_actions_id`) VALUES
(168, 1, 'LIST'),
(188, 2, 'LIST'),
(62, 3, 'EDIT'),
(63, 3, 'LIST'),
(172, 4, 'ADD'),
(173, 4, 'DELETE'),
(171, 4, 'EDIT'),
(174, 4, 'LIST'),
(163, 5, 'ADD'),
(164, 5, 'DELETE'),
(162, 5, 'EDIT'),
(165, 5, 'LIST'),
(187, 7, 'LIST'),
(260, 8, 'ADD'),
(261, 8, 'DELETE'),
(259, 8, 'EDIT'),
(262, 8, 'LIST'),
(301, 9, 'EDIT'),
(205, 9, 'LIST'),
(267, 10, 'LIST'),
(268, 11, 'LIST'),
(285, 12, 'ADD'),
(286, 12, 'DELETE'),
(287, 12, 'EDIT'),
(288, 12, 'LIST'),
(289, 13, 'ADD'),
(290, 13, 'DELETE'),
(291, 13, 'EDIT'),
(292, 13, 'LIST'),
(304, 14, 'ADD'),
(305, 14, 'DELETE'),
(306, 14, 'EDIT'),
(307, 14, 'LIST'),
(308, 15, 'LIST');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_roles`
--

DROP TABLE IF EXISTS `acl_roles`;
CREATE TABLE IF NOT EXISTS `acl_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` char(64) NOT NULL,
  `description` char(100) CHARACTER SET utf8 NOT NULL,
  `approved` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '1',
  `must_refresh` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `acl_roles`
--

INSERT INTO `acl_roles` (`id`, `role_name`, `description`, `approved`, `must_refresh`) VALUES
(1, 'Soporte', 'Perfil root.', '1', '0'),
(2, 'Administrador', 'Administrador con acceso a hacer modificaciones administrativas y manejo de usuarios.', '1', '0'),
(3, 'Consultas', 'Acceso a listados y reportes.', '1', '0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_roles_modules_actions`
--

DROP TABLE IF EXISTS `acl_roles_modules_actions`;
CREATE TABLE IF NOT EXISTS `acl_roles_modules_actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acl_roles_id` int(11) NOT NULL,
  `acl_modules_actions_id` int(11) NOT NULL,
  `permission` enum('ALLOW','DENY') CHARACTER SET utf8 NOT NULL DEFAULT 'ALLOW',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_roles_id` (`acl_roles_id`,`acl_modules_actions_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=158 ;

--
-- Volcado de datos para la tabla `acl_roles_modules_actions`
--

INSERT INTO `acl_roles_modules_actions` (`id`, `acl_roles_id`, `acl_modules_actions_id`, `permission`) VALUES
(1, 2, 168, 'ALLOW'),
(3, 2, 188, 'ALLOW'),
(5, 2, 62, 'ALLOW'),
(6, 2, 63, 'ALLOW'),
(8, 2, 162, 'ALLOW'),
(9, 2, 163, 'ALLOW'),
(10, 2, 164, 'ALLOW'),
(11, 2, 165, 'ALLOW'),
(15, 1, 168, 'ALLOW'),
(17, 1, 188, 'ALLOW'),
(26, 1, 62, 'ALLOW'),
(27, 1, 63, 'ALLOW'),
(33, 1, 171, 'ALLOW'),
(34, 1, 172, 'ALLOW'),
(35, 1, 173, 'ALLOW'),
(36, 1, 174, 'ALLOW'),
(37, 1, 187, 'ALLOW'),
(39, 1, 205, 'ALLOW'),
(44, 1, 162, 'ALLOW'),
(45, 1, 163, 'ALLOW'),
(46, 1, 164, 'ALLOW'),
(47, 1, 165, 'ALLOW'),
(62, 3, 188, 'ALLOW'),
(67, 3, 162, 'ALLOW'),
(68, 3, 163, 'ALLOW'),
(69, 3, 164, 'ALLOW'),
(70, 3, 165, 'ALLOW'),
(74, 3, 168, 'ALLOW'),
(105, 3, 62, 'ALLOW'),
(106, 3, 63, 'ALLOW'),
(123, 1, 259, 'ALLOW'),
(124, 1, 260, 'ALLOW'),
(125, 1, 261, 'ALLOW'),
(126, 1, 262, 'ALLOW'),
(131, 1, 267, 'ALLOW'),
(132, 1, 268, 'ALLOW'),
(133, 1, 289, 'ALLOW'),
(134, 1, 290, 'ALLOW'),
(135, 1, 291, 'ALLOW'),
(136, 1, 292, 'ALLOW'),
(145, 1, 285, 'ALLOW'),
(146, 1, 286, 'ALLOW'),
(147, 1, 287, 'ALLOW'),
(148, 1, 288, 'ALLOW'),
(151, 1, 301, 'ALLOW'),
(152, 1, 304, 'ALLOW'),
(153, 1, 305, 'ALLOW'),
(154, 1, 306, 'ALLOW'),
(155, 1, 307, 'ALLOW'),
(157, 1, 308, 'ALLOW');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_session`
--

DROP TABLE IF EXISTS `acl_session`;
CREATE TABLE IF NOT EXISTS `acl_session` (
  `id` char(32) NOT NULL DEFAULT '0',
  `acl_users_id` int(10) NOT NULL,
  `acl_roles_id` int(10) NOT NULL,
  `created` int(10) unsigned DEFAULT NULL,
  `modified` int(10) unsigned DEFAULT NULL,
  `lifetime` int(10) unsigned DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `data` text,
  `ip` varchar(20) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `must_refresh` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `acl_session`
--

INSERT INTO `acl_session` (`id`, `acl_users_id`, `acl_roles_id`, `created`, `modified`, `lifetime`, `image`, `data`, `ip`, `user_agent`, `must_refresh`) VALUES
('0bjcpplget4nvee4qfqbm9kbe6', 1, 1, 1426192419, 1426192420, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1426194820;s:10:"requestUri";s:6:"/admin";s:7:"storage";O:8:"stdClass":11:{s:2:"id";s:1:"1";s:12:"acl_roles_id";s:1:"1";s:9:"user_name";s:7:"gamelena";s:11:"first_names";s:7:"Soporte";s:10:"last_names";s:7:"Zweicom";s:5:"email";s:20:"tecnicos@gamelena.com";s:8:"approved";s:1:"1";s:4:"foto";N;s:12:"must_refresh";s:1:"0";s:16:"sessionNamespace";s:17:"tangerine-testing";s:6:"groups";a:0:{}}}', '127.0.0.1', 'Opera/9.80 (X11; Linux x86_64) Presto/2.12.388 Version/12.16', '0'),
('1914b1cfhc6qh3lartgvedbb62', 1, 1, 1426510232, 1426523054, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1426525453;s:10:"requestUri";s:12:"/admin/login";s:7:"storage";N;}', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36 FirePHP/4Chrome', '1'),
('51v7jq3klfili445sa08ngmkm3', 1, 1, 1447255537, 1447256625, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1447258760;s:10:"requestUri";s:161:"/crud-request?model=DbTable_TestingAbonados&&format=json&search[msisdn][value]=&search[msisdn][format]=&search[msisdn][operator]=&p=abonados.xml&start=0&count=25";s:7:"storage";O:8:"stdClass":11:{s:2:"id";s:1:"1";s:12:"acl_roles_id";s:1:"1";s:9:"user_name";s:7:"gamelena";s:11:"first_names";s:7:"Soporte";s:10:"last_names";s:7:"Zweicom";s:5:"email";s:20:"tecnicos@gamelena.com";s:8:"approved";s:1:"1";s:4:"foto";N;s:12:"must_refresh";s:1:"0";s:16:"sessionNamespace";s:17:"tangerine-testing";s:6:"groups";a:0:{}}}', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36 FirePHP/4Chrome', '1'),
('6j84mjs32gkrjdmf3gnlea8cp0', 1, 1, 1460922606, 1460922636, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1460925005;s:10:"requestUri";s:72:"/components/dojo-simple-crud/edit?p=users.xml&&primary[id]=2&p=users.xml";s:7:"storage";O:8:"stdClass":11:{s:2:"id";s:1:"1";s:12:"acl_roles_id";s:1:"1";s:9:"user_name";s:8:"gamelena";s:11:"first_names";s:7:"Soporte";s:10:"last_names";s:7:"Zweicom";s:5:"email";s:21:"tecnicos@gamelena.com";s:8:"approved";s:1:"1";s:4:"foto";N;s:12:"must_refresh";s:1:"0";s:16:"sessionNamespace";s:17:"tangerine-testing";s:6:"groups";a:0:{}}}', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36', '1'),
('6ufogbdqub9uthuhfvcpllvvv1', 1, 1, 1426192299, 1426192302, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1426194698;s:10:"requestUri";s:13:"/admin/login/";s:7:"storage";O:8:"stdClass":11:{s:2:"id";s:1:"1";s:12:"acl_roles_id";s:1:"1";s:9:"user_name";s:7:"gamelena";s:11:"first_names";s:7:"Soporte";s:10:"last_names";s:7:"Zweicom";s:5:"email";s:20:"tecnicos@gamelena.com";s:8:"approved";s:1:"1";s:4:"foto";N;s:12:"must_refresh";s:1:"0";s:16:"sessionNamespace";s:17:"tangerine-testing";s:6:"groups";a:0:{}}}', '127.0.0.1', 'Opera/9.80 (X11; Linux x86_64) Presto/2.12.388 Version/12.16', '1'),
('bs0kkmbel9jm34pd7qhb9lcf94', 1, 1, 1426282636, 1426283452, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1426285329;s:10:"requestUri";s:89:"/crud-request?model=TestingTraficoModel&format=json&p=graphic-trafic.xml&start=0&count=25";s:7:"storage";O:8:"stdClass":11:{s:2:"id";s:1:"1";s:12:"acl_roles_id";s:1:"1";s:9:"user_name";s:7:"gamelena";s:11:"first_names";s:7:"Soporte";s:10:"last_names";s:7:"Zweicom";s:5:"email";s:20:"tecnicos@gamelena.com";s:8:"approved";s:1:"1";s:4:"foto";N;s:12:"must_refresh";s:1:"0";s:16:"sessionNamespace";s:17:"tangerine-testing";s:6:"groups";a:0:{}}}', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0', '1'),
('bv29ntlst9131mh3pn10q96if0', 1, 1, 1426174538, 1426174576, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1426176945;s:10:"requestUri";s:45:"/crud-request?model=SettingsModel&format=json";s:7:"storage";O:8:"stdClass":11:{s:2:"id";s:1:"1";s:12:"acl_roles_id";s:1:"1";s:9:"user_name";s:7:"gamelena";s:11:"first_names";s:7:"Soporte";s:10:"last_names";s:7:"Zweicom";s:5:"email";s:20:"tecnicos@gamelena.com";s:8:"approved";s:1:"1";s:4:"foto";N;s:12:"must_refresh";s:1:"0";s:16:"sessionNamespace";s:17:"tangerine-testing";s:6:"groups";a:0:{}}}', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0', '1'),
('e9fnhpu857tfgfurrudb7ia3c5', 1, 1, 1424692753, 1424693969, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1424695480;s:10:"requestUri";s:46:"/admin/modules?dojo.preventCache=1424693080658";s:7:"storage";O:8:"stdClass":11:{s:2:"id";s:1:"1";s:12:"acl_roles_id";s:1:"1";s:9:"user_name";s:7:"gamelena";s:11:"first_names";s:7:"Soporte";s:10:"last_names";s:7:"Zweicom";s:5:"email";s:20:"tecnicos@gamelena.com";s:8:"approved";s:1:"1";s:4:"foto";N;s:12:"must_refresh";s:1:"0";s:16:"sessionNamespace";s:17:"ticketElectronico";s:6:"groups";a:0:{}}}', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0', '1'),
('ghgrur3mstmel2mu2pd7dtfoh5', 1, 1, 1426187927, 1426254915, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1426257313;s:10:"requestUri";s:12:"/admin/login";s:7:"storage";N;}', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36 FirePHP/4Chrome', '1'),
('hkmdr8dv18doha9fvrqinl8ob1', 1, 1, 1421246333, 1421248736, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1421251136;s:10:"requestUri";s:12:"/admin/login";s:7:"storage";N;}', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36 FirePHP/4Chrome', '1'),
('iejaa8r3hqqhonla79ilsnvnd1', 1, 1, 1426184055, 1426184089, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1426186459;s:10:"requestUri";s:46:"/admin/modules?dojo.preventCache=1426184058797";s:7:"storage";O:8:"stdClass":11:{s:2:"id";s:1:"1";s:12:"acl_roles_id";s:1:"1";s:9:"user_name";s:7:"gamelena";s:11:"first_names";s:7:"Soporte";s:10:"last_names";s:7:"Zweicom";s:5:"email";s:20:"tecnicos@gamelena.com";s:8:"approved";s:1:"1";s:4:"foto";N;s:12:"must_refresh";s:1:"0";s:16:"sessionNamespace";s:17:"tangerine-testing";s:6:"groups";a:0:{}}}', '127.0.0.1', 'Opera/9.80 (X11; Linux x86_64) Presto/2.12.388 Version/12.16', '1'),
('jik5vsorhu14l076kp22qfk234', 1, 1, 1427221272, 1427223710, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1427226110;s:10:"requestUri";s:12:"/admin/login";s:7:"storage";N;}', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36 FirePHP/4Chrome', '1'),
('r4o39q1buo2b0nqudq56v8e0f1', 1, 1, 1424439370, 1424442681, 864000, NULL, 'Zend_Auth|a:3:{s:7:"timeout";i:1424445081;s:10:"requestUri";s:12:"/admin/login";s:7:"storage";N;}', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_users`
--

DROP TABLE IF EXISTS `acl_users`;
CREATE TABLE IF NOT EXISTS `acl_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acl_roles_id` int(4) NOT NULL,
  `user_name` char(64) NOT NULL,
  `password` char(200) NOT NULL,
  `first_names` char(50) NOT NULL,
  `last_names` char(50) NOT NULL,
  `email` char(50) NOT NULL,
  `approved` enum('0','1') NOT NULL,
  `foto` varchar(256) DEFAULT NULL,
  `must_refresh` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `acl_users`
--

INSERT INTO `acl_users` (`id`, `acl_roles_id`, `user_name`, `password`, `first_names`, `last_names`, `email`, `approved`, `foto`, `must_refresh`) VALUES
(1, 1, 'gamelena', '31cb6a72f8f70612e27af0f59a9322ca', 'Soporte', 'Zweicom', 'tecnicos@gamelena.com', '1', NULL, '0'),
(2, 2, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrador', 'Cliente', '', '1', NULL, '0'),
(3, 3, 'consultas', '83da1fbc8f1a993de3f31cec6d7bf5b2', 'Consultas', 'Cliente', '', '1', NULL, '0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_users_groups`
--

DROP TABLE IF EXISTS `acl_users_groups`;
CREATE TABLE IF NOT EXISTS `acl_users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acl_users_id` int(11) NOT NULL,
  `acl_groups_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_users_id` (`acl_users_id`,`acl_groups_id`),
  KEY `fk_acl_users_groups_acl_users1` (`acl_users_id`),
  KEY `fk_acl_users_groups_acl_groups1` (`acl_groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_book`
--

DROP TABLE IF EXISTS `log_book`;
CREATE TABLE IF NOT EXISTS `log_book` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user` char(40) NOT NULL,
  `table` char(40) NOT NULL,
  `action` char(40) NOT NULL,
  `condition` char(200) NOT NULL,
  `acl_roles_id` int(11) NOT NULL,
  `ip` char(200) NOT NULL,
  `stamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `tables_logged`
--
DROP VIEW IF EXISTS `tables_logged`;
CREATE TABLE IF NOT EXISTS `tables_logged` (
`id` char(40)
,`title` char(40)
);
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `testing_abonados`
--

DROP TABLE IF EXISTS `testing_abonados`;
CREATE TABLE IF NOT EXISTS `testing_abonados` (
  `msisdn` bigint(11) NOT NULL,
  `list` int(2) NOT NULL,
  PRIMARY KEY (`msisdn`,`list`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `testing_abonados`
--

INSERT INTO `testing_abonados` (`msisdn`, `list`) VALUES
(23423423423, 3),
(23423423443, 42),
(36735673567, 35),
(44563456436, 50),
(44563456436, 51),
(45624635736, 33),
(51000000000, 4),
(51000000002, 3),
(51000000003, 4),
(51000000004, 5),
(51000000005, 6),
(51000000006, 1),
(51000000007, 2),
(51000000008, 3),
(51000000009, 4),
(51000000010, 5),
(51000000011, 6),
(51000000012, 1),
(51000000013, 2),
(51000000014, 3),
(51000000015, 4),
(51000000016, 5),
(51000000017, 6),
(51000000018, 1),
(51000000019, 2),
(51000000020, 3),
(51000000021, 4),
(51000000023, 5),
(51000000023, 6),
(51000000024, 1),
(51000000025, 2),
(51000000026, 3),
(51000000027, 4),
(51000000028, 5),
(51000000029, 6),
(51000000030, 1),
(51000000031, 2),
(51000000032, 3),
(51000000033, 4),
(51000000034, 5),
(51000000035, 6),
(51000000036, 1),
(51000000037, 2),
(51000000038, 3),
(51000000039, 4),
(51000000040, 5),
(51000000041, 6),
(51000000042, 1),
(51000000043, 2),
(51000000044, 3),
(51000000045, 4),
(51000000046, 5),
(51000000047, 6),
(51000000048, 1),
(51000000049, 2),
(51000000050, 3),
(51000000051, 4),
(51000000052, 5),
(51000000053, 6),
(51000000054, 1),
(51000000055, 2),
(51000000056, 3),
(51000000057, 4),
(51000000058, 5),
(51000000059, 6),
(51000000060, 1),
(51000000061, 2),
(51000000062, 3),
(51000000063, 4),
(51000000064, 5),
(51000000065, 6),
(51000000066, 1),
(51000000067, 2),
(51000000068, 3),
(51000000069, 4),
(51000000070, 5),
(51000000071, 6),
(51000000072, 1),
(51000000073, 2),
(51000000074, 3),
(51000000075, 4),
(51000000076, 5),
(51000000077, 6),
(51000000078, 1),
(51000000079, 2),
(51000000080, 3),
(51000000081, 4),
(51000000082, 5),
(51000000083, 6),
(51000000084, 1),
(51000000085, 2),
(51000000086, 3),
(51000000087, 4),
(51000000088, 5),
(51000000089, 6),
(51000000090, 1),
(51000000091, 2),
(51000000092, 3),
(51000000093, 4),
(51000000094, 5),
(51000000095, 6),
(51000000096, 1),
(51000000097, 2),
(51000000098, 3),
(51000000099, 1),
(51000000099, 4),
(78978978979, 89);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `testing_trafico`
--

DROP TABLE IF EXISTS `testing_trafico`;
CREATE TABLE IF NOT EXISTS `testing_trafico` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_promo` varchar(32) NOT NULL COMMENT 'id promocion',
  `modulo` varchar(32) NOT NULL COMMENT 'Modulo que realizo la transaccion',
  `usuario` varchar(32) NOT NULL,
  `operacion` varchar(25) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '0',
  `contador` bigint(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_icons`
--

DROP TABLE IF EXISTS `web_icons`;
CREATE TABLE IF NOT EXISTS `web_icons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Volcado de datos para la tabla `web_icons`
--

INSERT INTO `web_icons` (`id`, `title`, `image`) VALUES
(1, 'Sphere Green', '033d4c25green-sphere.png'),
(2, 'Sphere Blue', '225ca2a1step4c.png'),
(3, 'Sphere Red', '23cf88ccred-sphere-2.png'),
(4, 'Sphere Yellow', 'dedbeb01yellow-sphere.png'),
(5, 'Keys', 'a3093747roles.png'),
(6, 'Module', '03e490e9blockdevice.png'),
(7, 'Roles', '547353feuser-group-icon.png'),
(8, 'Teams', '630e0daesocial-networking-package.jpg'),
(9, 'Online', 'ab789f0auser-online.png'),
(10, 'Chart', '325d3cbfarea-chart-256.png'),
(11, 'Magnifier', '905dbb5bwindows-7-magnifier.png'),
(12, 'Settings', 'e0d79f05setting-icon.png'),
(13, 'Settings 2', '91732629iphone-settings-icon.png'),
(14, 'Audit', '751f9170audit.png'),
(15, 'Setup', '0d7df408setup-l.png'),
(16, 'USSD', 'c62b4507bitdefender-ussd-wipe-stopper.png'),
(17, 'User', 'a4c40f07actions-im-user-icon.png'),
(18, 'Package', 'c244255a50px-crystal-package.png'),
(19, 'Sale', '8a6ca637activshow-icon.png'),
(20, 'Global', '9f8eb80dworld.png'),
(21, 'Setup Warning', '11e455ecsetup.png'),
(22, 'Server', '3ff898e8server-icon.png'),
(23, 'Reporte', '7612a7b7reports.png'),
(24, 'CSV', 'ad4c5a07csv.png'),
(25, 'Debug', '5cd23e7edebug2.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_settings`
--

DROP TABLE IF EXISTS `web_settings`;
CREATE TABLE IF NOT EXISTS `web_settings` (
  `id` char(255) NOT NULL DEFAULT '',
  `list` char(255) NOT NULL,
  `value` char(255) NOT NULL DEFAULT '0',
  `type` char(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `ord` int(11) NOT NULL DEFAULT '0',
  `group` char(255) NOT NULL,
  `function` char(255) NOT NULL,
  `approved` enum('0','1') NOT NULL,
  `path` varchar(50) NOT NULL,
  `url` varchar(256) DEFAULT NULL,
  `regExp` varchar(60) NOT NULL,
  `invalidMessage` varchar(50) NOT NULL,
  `promptMessage` varchar(50) NOT NULL,
  `formatter` varchar(25) NOT NULL,
  `xml_children` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group` (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `web_settings`
--

INSERT INTO `web_settings` (`id`, `list`, `value`, `type`, `description`, `ord`, `group`, `function`, `approved`, `path`, `url`, `regExp`, `invalidMessage`, `promptMessage`, `formatter`, `xml_children`) VALUES
('credits', '', '&copy; Zweicom 2015', 'dijit-form-validation-text-box', '', 2, 'Admin', '', '1', '', NULL, '', '', '', '', ''),
('query_log', '', '1', 'dijit-form-check-box', '', 1, 'Debug', '', '1', '', NULL, '', '', '', '', ''),
('titulo_adm', '', 'Tangerine Testing', 'dijit-form-validation-text-box', '', 1, 'Admin', '', '1', '', NULL, '', '', '', '', ''),
('transactions_log', '', '1', 'dijit-form-check-box', '', 1, 'Debug', '', '1', '', NULL, '', '', '', '', ''),
('url_logo_gamelena', '', 'b28576bblogo-gamelena-26x34.png', 'dojox-form-uploader', '', 3, 'Admin', '', '1', '{ROOT_DIR}/public/upfiles/', '{BASE_URL}/upfiles/corporative/', '', '', '', 'formatImage', '&lt;thumb height="18" path="{ROOT_DIR}/public/upfiles/corporative/" /&gt;\r\n'),
('url_logo_oper', '', 'b07d49fdlogo-gamelena-big.png', 'dojox-form-uploader', '', 3, 'Admin', '', '1', '{ROOT_DIR}/public/upfiles/', '{BASE_URL}/upfiles/corporative/', '', '', '', 'formatImage', '&lt;thumb height="56" path="{ROOT_DIR}/public/upfiles/corporative/" /&gt;');

-- --------------------------------------------------------

--
-- Estructura para la vista `tables_logged`
--
DROP TABLE IF EXISTS `tables_logged`;

CREATE ALGORITHM=UNDEFINED DEFINER=`tangerine_user`@`localhost` SQL SECURITY DEFINER VIEW `tables_logged` AS select distinct `log_book`.`table` AS `id`,`log_book`.`table` AS `title` from `log_book` order by `log_book`.`table`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;