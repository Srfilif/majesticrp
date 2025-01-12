-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 12-01-2025 a las 02:11:49
-- Versión del servidor: 10.6.18-MariaDB-0ubuntu0.22.04.1
-- Versión de PHP: 8.1.2-1ubuntu2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `s6674_Greenwood`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `staff` tinyint(1) DEFAULT 0,
  `vip` tinyint(1) DEFAULT 0,
  `creditos` int(11) DEFAULT 0,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `nombre`, `pass`, `fecha_registro`, `staff`, `vip`, `creditos`, `email`) VALUES
(1, 'usuario123', '8e7ab8d9fe3b324acdd1f76735eea350ea61ac24cbd17e5446946e5a4c71d999', '2024-12-21 12:59:26', 0, 1, 100, 'pene'),
(3, 'srfilif', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', '2025-01-05 17:55:04', 0, 0, 0, NULL),
(6, 'dilanrdz91', '21b2840a2cdb87c8539927b2c185931a794dc9e062836254bb1e7482e8f92182', '2025-01-05 01:17:48', 0, 1, 1000, NULL),
(8, 'Cirolf', '7c4e4e4db5cff8e3cd82c9ccbec4573ffee37e0d603a47453051f5c83f70eb25', '2025-01-06 06:35:20', 0, 0, 0, NULL),
(9, 'Limon', '404cdec150f747cb2f987f2ad5b27d5b92e1250219f585ec014951352dec9905', '2025-01-10 22:57:36', 0, 0, 0, NULL),
(10, 'juampidiazon', '2eb4ee9e32ed2c62bd162826e8028ca6eca7d5cf890ebc64f3d7e17a79a3d872', '2025-01-11 02:43:04', 0, 0, 0, NULL),
(11, 'MarcosDiament', '6ee273f3456c75199012b1014a088b3270859852042c5117efb1e62eee549b4f', '2025-01-11 03:41:35', 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dudas`
--

CREATE TABLE `dudas` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(50) DEFAULT NULL,
  `duda` text DEFAULT NULL,
  `fecha` int(50) DEFAULT current_timestamp(),
  `account_id` int(11) DEFAULT NULL,
  `respuesta` text DEFAULT NULL,
  `staff` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dudas`
--

INSERT INTO `dudas` (`id`, `nombre_usuario`, `duda`, `fecha`, `account_id`, `respuesta`, `staff`) VALUES
(16, 'Andres_Angel', 'Hola', 1736450603, 3, 'holap', 0),
(18, 'Andres_Angel', 'hola', 1736451278, 3, NULL, NULL),
(19, 'Andres_Angel', 'hola', 1736451278, 3, NULL, NULL),
(20, 'Andres_Angel', 'hola', 1736451278, 3, NULL, NULL),
(21, 'Andres_Angel', 'hola', 1736451445, 3, NULL, NULL),
(22, 'Andres_Angel', 'hola', 1736451793, 3, NULL, NULL),
(23, 'Amado_Camarillo', 'Prueba ...', 1736458560, 6, NULL, NULL),
(24, 'James_Parker', 'SEXOOOOOOOOOO', 1736563582, 10, 'Callate sapa', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Inventario`
--

CREATE TABLE `Inventario` (
  `Jugador` text DEFAULT NULL,
  `Item` text DEFAULT NULL,
  `Value` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Inventario`
--

INSERT INTO `Inventario` (`Jugador`, `Item`, `Value`) VALUES
('0', 'Caja de Cigarros', 60),
('0', 'Caja de Herramientas', 1),
('Andres_Angel', 'Agua', 3),
('Amado_Camarillo', 'Pollo Asado', 1),
('Amado_Camarillo', 'Hamb. de Pollo', 1),
('Amado_Camarillo', 'Pizza Grande', 1),
('Andres_Angel', 'Pizza Chica', 3),
('Andres_Angel', 'Caja de Herramientas', 1),
('Andres_Angel', 'Licencia de Armas (Clase A)', 1),
('Amado_Camarillo', 'Bidon Vacio', 1),
('Amado_Camarillo', 'Caja de Cigarros', 60),
('Amado_Camarillo', 'Licencia de Armas (Clase A)', 1),
('Amado_Camarillo', 'Encendedor', -1),
('Amado_Camarillo', 'Medicamentos', 4),
('Amado_Camarillo', 'Bisturi', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetos_suelo`
--

CREATE TABLE `objetos_suelo` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `z` int(11) NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personajes`
--

CREATE TABLE `personajes` (
  `id` int(11) NOT NULL,
  `cuenta_id` int(11) NOT NULL,
  `nombre_apellido` varchar(50) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `dinero` int(11) DEFAULT 0,
  `nivel` int(11) DEFAULT 1,
  `experiencia` int(11) DEFAULT 0,
  `ubicacion_x` float DEFAULT 0,
  `ubicacion_y` float DEFAULT 0,
  `ubicacion_z` float DEFAULT 0,
  `salud` float DEFAULT 100,
  `armadura` float DEFAULT 0,
  `Sexo` text NOT NULL DEFAULT 'Masculino',
  `TestRoleplay` text NOT NULL DEFAULT 'No',
  `Nacionalidad` text DEFAULT NULL,
  `Edad` int(11) DEFAULT NULL,
  `DNI` int(11) DEFAULT NULL,
  `armas` text DEFAULT NULL,
  `Trabajo` text DEFAULT NULL,
  `Skin` int(11) NOT NULL DEFAULT 2,
  `interior` int(11) DEFAULT NULL,
  `dimencion` int(11) DEFAULT NULL,
  `caminata` int(11) NOT NULL DEFAULT 118,
  `portearma` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personajes`
--

INSERT INTO `personajes` (`id`, `cuenta_id`, `nombre_apellido`, `pass`, `fecha_creacion`, `dinero`, `nivel`, `experiencia`, `ubicacion_x`, `ubicacion_y`, `ubicacion_z`, `salud`, `armadura`, `Sexo`, `TestRoleplay`, `Nacionalidad`, `Edad`, `DNI`, `armas`, `Trabajo`, `Skin`, `interior`, `dimencion`, `caminata`, `portearma`) VALUES
(2, 1, 'Carlos_Angel', '12', '2024-12-21 18:17:59', 1233, 12, 0, 240.75, 40.25, -62.1598, 100, 0, '', 'No', '', 0, 0, '[ [ ] ]', '', 0, 0, 0, 118, 0),
(6, 1, 'Mark_Angel', '20', '2024-12-21 19:03:30', 12130, 1, 0, 125, -172.625, 1.57812, 100, 0, 'M', 'No', 'Español', 22, 0, '[ [ ] ]', '', 0, 0, 0, 118, 0),
(24, 6, 'Amado_Camarillo', 'laolvide', '2025-01-05 01:22:07', 996138129, 3, 4, 1339.85, -1113.33, 23.615, 68, 88, 'Masculino', 'Si', 'Estadounidense', 33, NULL, '[ [ { \"ammo\": 375, \"weapon\": 22 } ] ]', NULL, 280, 0, 0, 121, 1),
(25, 3, 'Andres_Angel', '12345andres', '2025-01-05 01:22:07', 5446780, 4, 6, 1565.32, -1674.67, 16.1953, 86, 0, 'Masculino', 'Si', 'Estadounidense', 33, NULL, '[ [ ] ]', NULL, 280, 0, 0, 121, 1),
(26, 11, 'Marcos_Brown', '12345', '2025-01-10 23:19:00', 93140, 1, 1, 2151.57, -1842.47, 3.98438, 71, 0, 'Masculino', 'Si', 'Colombiana', 22, NULL, '[ [ ] ]', NULL, 309, 0, 0, 118, 0),
(27, 9, 'Kewan_Stoke', 'laolvide', '2025-01-05 01:22:07', 1, 2, 5, 961.857, -978.65, 38.8515, 100, 0, 'Masculino', 'Si', 'Estadounidense', 33, NULL, '[ [ { \"ammo\": 172, \"weapon\": 24 } ] ]', NULL, 292, 0, 0, 121, 1),
(28, 10, 'James_Parker', 'juampi24', '2025-01-11 02:45:33', 48220, 1, 2, 1043.1, -1575.71, 13.3828, 100, 100, 'Masculino', 'Si', 'Argentina', 27, NULL, '[ [ ] ]', NULL, 217, 0, 0, 118, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(255) DEFAULT NULL,
  `reporte` text DEFAULT NULL,
  `fecha` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `status` text NOT NULL DEFAULT 'open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reportes`
--

INSERT INTO `reportes` (`id`, `nombre_usuario`, `reporte`, `fecha`, `account_id`, `status`) VALUES
(8, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736140879, 3, 'open'),
(9, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736140950, 3, 'open'),
(10, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141188, 3, 'open'),
(11, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141227, 3, 'open'),
(12, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141289, 3, 'open'),
(13, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141314, 3, 'open'),
(14, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141327, 3, 'open'),
(15, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141371, 3, 'open'),
(16, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141392, 3, 'open'),
(17, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141415, 3, 'open'),
(18, 'Andres_Angel', '¡Aca tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y que normativa estan infligiendo\n', 1736141442, 3, 'open'),
(19, 'Andres_Angel', 'hola pene\n', 1736141746, 3, 'open'),
(20, 'Andres_Angel', '\n', 1736141795, 3, 'open'),
(21, 'Andres_Angel', 'fdsfsdfffdsfsdfdsfsd\n', 1736141852, 3, 'open'),
(22, 'Amado_Camarillo', 'KSKSKSKSKSKSK ddddddddddddddddddddddd\n', 1736145705, 6, 'open'),
(23, 'Andres_Angel', 'fsdfsdfsdfsdfsfsdfsdfdsf\n', 1736262694, 3, 'open'),
(24, 'Andres_Angel', '* El reporte es muy corto. Proporcione más detalles.\n* El reporte es muy corto. Proporcione más detalles.* El reporte es muy corto. Proporcione más detalles.\n* El reporte es muy corto. Proporcione más detalles.\n', 1736262773, 3, 'open'),
(25, 'Andres_Angel', '* El reporte es muy corto. Proporcione más detalles.* El reporte es muy corto. Proporcione más detalles.\n', 1736262788, 3, 'open'),
(26, 'Andres_Angel', 'fsdgfdggggggggggggggggggggggggggggggggggggg\n', 1736262834, 3, 'open'),
(27, 'Kewan_Stoke', 'AYUDA ESTOY BUGATI JHONSON\n', 1736561181, 9, 'open');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `dudas`
--
ALTER TABLE `dudas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `objetos_suelo`
--
ALTER TABLE `objetos_suelo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personajes`
--
ALTER TABLE `personajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuenta_id` (`cuenta_id`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `dudas`
--
ALTER TABLE `dudas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `objetos_suelo`
--
ALTER TABLE `objetos_suelo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `personajes`
--
ALTER TABLE `personajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `personajes`
--
ALTER TABLE `personajes`
  ADD CONSTRAINT `personajes_ibfk_1` FOREIGN KEY (`cuenta_id`) REFERENCES `cuentas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
