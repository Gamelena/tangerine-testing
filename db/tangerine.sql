-- phpMyAdmin SQL Dump
-- version 4.4.13.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 18-04-2016 a las 10:08:29
-- Versión del servidor: 5.6.28-0ubuntu0.15.10.1
-- Versión de PHP: 5.6.11-1ubuntu3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

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
  `title` varchar(50) NOT NULL
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
  `id` int(11) NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `approved` enum('0','1') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_groups_modules_actions`
--

DROP TABLE IF EXISTS `acl_groups_modules_actions`;
CREATE TABLE IF NOT EXISTS `acl_groups_modules_actions` (
  `id` int(11) NOT NULL,
  `acl_modules_actions_id` int(10) NOT NULL,
  `acl_groups_id` int(11) NOT NULL,
  `acl_modules_item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_modules`
--

DROP TABLE IF EXISTS `acl_modules`;
CREATE TABLE IF NOT EXISTS `acl_modules` (
  `id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Id de Módulo padre',
  `title` char(200) DEFAULT NULL COMMENT 'Nombre',
  `module` char(200) DEFAULT NULL COMMENT 'Url de módulo, puede ser archivo XML, URl de controlador o módulo ZF',
  `tree` enum('0','1') NOT NULL DEFAULT '1',
  `refresh_on_load` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Define si módulo debe ser refrescado al reseleccionar la pestaña, en caso contrario mantendrá el estatus de como se dejó al abandonarla.',
  `type` enum('xml','zend_module','iframe') DEFAULT 'xml',
  `approved` enum('0','1') NOT NULL DEFAULT '1',
  `order` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'Orden en que aparece en arbol',
  `root` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Define si solo puede acceder perfil ROOT (en configuracion por defecto acl_roles_id = 1)',
  `ownership` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Indica si modulo usa modelo con reglas de owner, funciona con type=xml, ver Zwei_Db_Table::isOwner(item, user)',
  `icons_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

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
  `id` int(10) unsigned NOT NULL,
  `acl_modules_id` int(11) NOT NULL,
  `acl_actions_id` varchar(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=latin1;

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
  `id` int(11) NOT NULL,
  `role_name` char(64) NOT NULL,
  `description` char(100) CHARACTER SET utf8 NOT NULL,
  `approved` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '1',
  `must_refresh` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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
  `id` int(10) unsigned NOT NULL,
  `acl_roles_id` int(11) NOT NULL,
  `acl_modules_actions_id` int(11) NOT NULL,
  `permission` enum('ALLOW','DENY') CHARACTER SET utf8 NOT NULL DEFAULT 'ALLOW'
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=latin1;

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
  `must_refresh` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acl_users`
--

DROP TABLE IF EXISTS `acl_users`;
CREATE TABLE IF NOT EXISTS `acl_users` (
  `id` int(11) NOT NULL,
  `acl_roles_id` int(4) NOT NULL,
  `user_name` char(64) NOT NULL,
  `password` char(200) NOT NULL,
  `first_names` char(50) NOT NULL,
  `last_names` char(50) NOT NULL,
  `email` char(50) NOT NULL,
  `approved` enum('0','1') NOT NULL,
  `foto` varchar(256) DEFAULT NULL,
  `must_refresh` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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
  `id` int(11) NOT NULL,
  `acl_users_id` int(11) NOT NULL,
  `acl_groups_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_book`
--

DROP TABLE IF EXISTS `log_book`;
CREATE TABLE IF NOT EXISTS `log_book` (
  `id` bigint(20) unsigned NOT NULL,
  `user` char(40) NOT NULL,
  `table` char(40) NOT NULL,
  `action` char(40) NOT NULL,
  `condition` char(200) NOT NULL,
  `acl_roles_id` int(11) NOT NULL,
  `ip` char(200) NOT NULL,
  `stamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `list` int(2) NOT NULL
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
  `id` int(9) unsigned NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_promo` varchar(32) NOT NULL COMMENT 'id promocion',
  `modulo` varchar(32) NOT NULL COMMENT 'Modulo que realizo la transaccion',
  `usuario` varchar(32) NOT NULL,
  `operacion` varchar(25) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '0',
  `contador` bigint(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_icons`
--

DROP TABLE IF EXISTS `web_icons`;
CREATE TABLE IF NOT EXISTS `web_icons` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

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
  `xml_children` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `web_settings`
--

INSERT INTO `web_settings` (`id`, `list`, `value`, `type`, `description`, `ord`, `group`, `function`, `approved`, `path`, `url`, `regExp`, `invalidMessage`, `promptMessage`, `formatter`, `xml_children`) VALUES
('credits', '', '&copy; Zweicom 2015', 'dijit-form-validation-text-box', '', 2, 'Admin', '', '1', '', NULL, '', '', '', '', ''),
('query_log', '', '1', 'dijit-form-check-box', '', 1, 'Debug', '', '1', '', NULL, '', '', '', '', ''),
('titulo_adm', '', 'Tangerine Testing', 'dijit-form-validation-text-box', '', 1, 'Admin', '', '1', '', NULL, '', '', '', '', ''),
('transactions_log', '', '1', 'dijit-form-check-box', '', 1, 'Debug', '', '1', '', NULL, '', '', '', '', ''),
('url_logo_gamelena', '', '1c3aa131gamelena.png', 'dojox-form-uploader', '', 3, 'Admin', '', '1', '{ROOT_DIR}/public/upfiles/', '{BASE_URL}/upfiles/corporative/', '', '', '', 'formatImage', '&lt;thumb height="18" path="{ROOT_DIR}/public/upfiles/corporative/" /&gt;\r\n'),
('url_logo_oper', '', '5d622878gamelena.png', 'dojox-form-uploader', '', 3, 'Admin', '', '1', '{ROOT_DIR}/public/upfiles/', '{BASE_URL}/upfiles/corporative/', '', '', '', 'formatImage', '&lt;thumb height="56" path="{ROOT_DIR}/public/upfiles/corporative/" /&gt;');

-- --------------------------------------------------------

--
-- Estructura para la vista `tables_logged`
--
DROP TABLE IF EXISTS `tables_logged`;

CREATE ALGORITHM=UNDEFINED DEFINER=`tangerine_user`@`localhost` SQL SECURITY DEFINER VIEW `tables_logged` AS select distinct `log_book`.`table` AS `id`,`log_book`.`table` AS `title` from `log_book` order by `log_book`.`table`;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acl_actions`
--
ALTER TABLE `acl_actions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `acl_groups`
--
ALTER TABLE `acl_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `acl_groups_modules_actions`
--
ALTER TABLE `acl_groups_modules_actions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `acl_modules_actions_id` (`acl_modules_actions_id`,`acl_groups_id`,`acl_modules_item_id`),
  ADD KEY `fk_acl_groups_modules_actions_acl_modules_actions1` (`acl_modules_actions_id`),
  ADD KEY `fk_acl_groups_modules_actions_acl_groups1` (`acl_groups_id`);

--
-- Indices de la tabla `acl_modules`
--
ALTER TABLE `acl_modules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `module` (`module`);

--
-- Indices de la tabla `acl_modules_actions`
--
ALTER TABLE `acl_modules_actions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `acl_modules_id` (`acl_modules_id`,`acl_actions_id`);

--
-- Indices de la tabla `acl_roles`
--
ALTER TABLE `acl_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indices de la tabla `acl_roles_modules_actions`
--
ALTER TABLE `acl_roles_modules_actions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `acl_roles_id` (`acl_roles_id`,`acl_modules_actions_id`);

--
-- Indices de la tabla `acl_session`
--
ALTER TABLE `acl_session`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `acl_users`
--
ALTER TABLE `acl_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- Indices de la tabla `acl_users_groups`
--
ALTER TABLE `acl_users_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `acl_users_id` (`acl_users_id`,`acl_groups_id`),
  ADD KEY `fk_acl_users_groups_acl_users1` (`acl_users_id`),
  ADD KEY `fk_acl_users_groups_acl_groups1` (`acl_groups_id`);

--
-- Indices de la tabla `log_book`
--
ALTER TABLE `log_book`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `testing_abonados`
--
ALTER TABLE `testing_abonados`
  ADD PRIMARY KEY (`msisdn`,`list`);

--
-- Indices de la tabla `testing_trafico`
--
ALTER TABLE `testing_trafico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `web_icons`
--
ALTER TABLE `web_icons`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `web_settings`
--
ALTER TABLE `web_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group` (`group`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acl_groups`
--
ALTER TABLE `acl_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `acl_groups_modules_actions`
--
ALTER TABLE `acl_groups_modules_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `acl_modules`
--
ALTER TABLE `acl_modules`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `acl_modules_actions`
--
ALTER TABLE `acl_modules_actions`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=310;
--
-- AUTO_INCREMENT de la tabla `acl_roles`
--
ALTER TABLE `acl_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `acl_roles_modules_actions`
--
ALTER TABLE `acl_roles_modules_actions`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=158;
--
-- AUTO_INCREMENT de la tabla `acl_users`
--
ALTER TABLE `acl_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `acl_users_groups`
--
ALTER TABLE `acl_users_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `log_book`
--
ALTER TABLE `log_book`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `testing_trafico`
--
ALTER TABLE `testing_trafico`
  MODIFY `id` int(9) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `web_icons`
--
ALTER TABLE `web_icons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;