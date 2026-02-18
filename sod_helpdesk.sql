-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 18, 2026 at 07:58 AM
-- Server version: 8.0.36-1
-- PHP Version: 8.4.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sod_helpdesk`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_ticket_classifications`
--

CREATE TABLE `ai_ticket_classifications` (
  `id` bigint UNSIGNED NOT NULL,
  `ticket_id` int UNSIGNED NOT NULL,
  `priority_id` int UNSIGNED DEFAULT NULL,
  `category_id` int UNSIGNED DEFAULT NULL,
  `department_id` int UNSIGNED DEFAULT NULL,
  `type_id` int UNSIGNED DEFAULT NULL,
  `confidence_score` decimal(5,2) NOT NULL DEFAULT '0.00',
  `reasoning` text COLLATE utf8mb4_unicode_ci,
  `ai_generated` tinyint(1) NOT NULL DEFAULT '1',
  `classification_data` json DEFAULT NULL,
  `applied` tinyint(1) NOT NULL DEFAULT '0',
  `applied_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `id` int UNSIGNED NOT NULL,
  `ticket_id` int DEFAULT NULL,
  `conversation_id` bigint UNSIGNED DEFAULT NULL,
  `message_id` int DEFAULT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `contact_id` int DEFAULT NULL,
  `size` int DEFAULT NULL,
  `path` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auto_assignment_rules`
--

CREATE TABLE `auto_assignment_rules` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `priority` int NOT NULL DEFAULT '0',
  `conditions` json DEFAULT NULL,
  `assignment_type` enum('user','department','round_robin','workload_based') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `assigned_user_id` bigint UNSIGNED DEFAULT NULL,
  `assigned_department_id` int UNSIGNED DEFAULT NULL,
  `assignment_config` json DEFAULT NULL,
  `max_tickets_per_user` int DEFAULT NULL,
  `consider_workload` tinyint(1) NOT NULL DEFAULT '1',
  `consider_skills` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `backup`
--

CREATE TABLE `backup` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `department_id`, `parent_id`, `color`) VALUES
(1, 'New Customer', 1, NULL, NULL),
(2, 'Existing Customer', 1, NULL, NULL),
(3, 'Event', 2, NULL, NULL),
(4, 'Meeting', 2, NULL, NULL),
(5, 'Domain Issue', 3, NULL, NULL),
(6, 'Hosting Issue', 3, NULL, NULL),
(7, 'Domain', 4, NULL, NULL),
(8, 'Hosting', 4, NULL, NULL),
(9, 'Domain Price', NULL, 7, NULL),
(10, 'Domain Purchase', NULL, 7, NULL),
(11, 'Purchasing a new hosting', NULL, 8, NULL),
(12, 'Pricing about hosting', NULL, 8, NULL),
(13, 'New Event', NULL, 3, NULL),
(14, 'Upcoming Event', NULL, 3, NULL),
(15, 'Arrange A Meeting', NULL, 4, NULL),
(16, 'Join with a call', NULL, 4, NULL),
(17, 'Purchase Help', NULL, 1, NULL),
(18, 'Pricing List', NULL, 1, NULL),
(19, 'Migrate hosting plan', NULL, 2, NULL),
(20, 'Change DNS', NULL, 2, NULL),
(21, 'Existing DNS is not working', NULL, 5, NULL),
(22, 'DNS Conflict', NULL, 5, NULL),
(23, 'Server is not working', NULL, 6, NULL),
(24, 'Low Speed', NULL, 6, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `chat_sessions`
--

CREATE TABLE `chat_sessions` (
  `id` bigint UNSIGNED NOT NULL,
  `conversation_id` bigint UNSIGNED NOT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `last_activity` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_typing_indicators`
--

CREATE TABLE `chat_typing_indicators` (
  `id` bigint UNSIGNED NOT NULL,
  `conversation_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `contact_id` int UNSIGNED DEFAULT NULL,
  `is_typing` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int UNSIGNED NOT NULL,
  `ticket_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `contact_id` int DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int UNSIGNED NOT NULL,
  `organization_id` int DEFAULT NULL,
  `first_name` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','resolved','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `last_message_at` timestamp NULL DEFAULT NULL,
  `priority` enum('low','medium','high','urgent') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `department` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `source` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'website',
  `metadata` json DEFAULT NULL,
  `last_activity` timestamp NULL DEFAULT NULL,
  `contact_id` int NOT NULL,
  `ticket_id` int UNSIGNED DEFAULT NULL,
  `type` enum('internal','customer','support') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `created_by` int UNSIGNED DEFAULT NULL,
  `context` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int UNSIGNED NOT NULL,
  `code` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `code`, `name`) VALUES
(1, 'AF', 'Afghanistan'),
(2, 'AX', 'Åland Islands'),
(3, 'AL', 'Albania'),
(4, 'DZ', 'Algeria'),
(5, 'AS', 'American Samoa'),
(6, 'AD', 'Andorra'),
(7, 'AO', 'Angola'),
(8, 'AI', 'Anguilla'),
(9, 'AQ', 'Antarctica'),
(10, 'AG', 'Antigua and Barbuda'),
(11, 'AR', 'Argentina'),
(12, 'AM', 'Armenia'),
(13, 'AW', 'Aruba'),
(14, 'AU', 'Australia'),
(15, 'AT', 'Austria'),
(16, 'AZ', 'Azerbaijan'),
(17, 'BS', 'Bahamas'),
(18, 'BH', 'Bahrain'),
(19, 'BD', 'Bangladesh'),
(20, 'BB', 'Barbados'),
(21, 'BY', 'Belarus'),
(22, 'BE', 'Belgium'),
(23, 'BZ', 'Belize'),
(24, 'BJ', 'Benin'),
(25, 'BM', 'Bermuda'),
(26, 'BT', 'Bhutan'),
(27, 'BO', 'Bolivia, Plurinational State of'),
(28, 'BQ', 'Bonaire, Sint Eustatius and Saba'),
(29, 'BA', 'Bosnia and Herzegovina'),
(30, 'BW', 'Botswana'),
(31, 'BV', 'Bouvet Island'),
(32, 'BR', 'Brazil'),
(33, 'IO', 'British Indian Ocean Territory'),
(34, 'BN', 'Brunei Darussalam'),
(35, 'BG', 'Bulgaria'),
(36, 'BF', 'Burkina Faso'),
(37, 'BI', 'Burundi'),
(38, 'KH', 'Cambodia'),
(39, 'CM', 'Cameroon'),
(40, 'CA', 'Canada'),
(41, 'CV', 'Cape Verde'),
(42, 'KY', 'Cayman Islands'),
(43, 'CF', 'Central African Republic'),
(44, 'TD', 'Chad'),
(45, 'CL', 'Chile'),
(46, 'CN', 'China'),
(47, 'CX', 'Christmas Island'),
(48, 'CC', 'Cocos (Keeling) Islands'),
(49, 'CO', 'Colombia'),
(50, 'KM', 'Comoros'),
(51, 'CG', 'Congo'),
(52, 'CD', 'Congo, the Democratic Republic of the'),
(53, 'CK', 'Cook Islands'),
(54, 'CR', 'Costa Rica'),
(55, 'CI', 'Côte d\'Ivoire'),
(56, 'HR', 'Croatia'),
(57, 'CU', 'Cuba'),
(58, 'CW', 'Curaçao'),
(59, 'CY', 'Cyprus'),
(60, 'CZ', 'Czech Republic'),
(61, 'DK', 'Denmark'),
(62, 'DJ', 'Djibouti'),
(63, 'DM', 'Dominica'),
(64, 'DO', 'Dominican Republic'),
(65, 'EC', 'Ecuador'),
(66, 'EG', 'Egypt'),
(67, 'SV', 'El Salvador'),
(68, 'GQ', 'Equatorial Guinea'),
(69, 'ER', 'Eritrea'),
(70, 'EE', 'Estonia'),
(71, 'ET', 'Ethiopia'),
(72, 'FK', 'Falkland Islands (Malvinas)'),
(73, 'FO', 'Faroe Islands'),
(74, 'FJ', 'Fiji'),
(75, 'FI', 'Finland'),
(76, 'FR', 'France'),
(77, 'GF', 'French Guiana'),
(78, 'PF', 'French Polynesia'),
(79, 'TF', 'French Southern Territories'),
(80, 'GA', 'Gabon'),
(81, 'GM', 'Gambia'),
(82, 'GE', 'Georgia'),
(83, 'DE', 'Germany'),
(84, 'GH', 'Ghana'),
(85, 'GI', 'Gibraltar'),
(86, 'GR', 'Greece'),
(87, 'GL', 'Greenland'),
(88, 'GD', 'Grenada'),
(89, 'GP', 'Guadeloupe'),
(90, 'GU', 'Guam'),
(91, 'GT', 'Guatemala'),
(92, 'GG', 'Guernsey'),
(93, 'GN', 'Guinea'),
(94, 'GW', 'Guinea-Bissau'),
(95, 'GY', 'Guyana'),
(96, 'HT', 'Haiti'),
(97, 'HM', 'Heard Island and McDonald Mcdonald Islands'),
(98, 'VA', 'Holy See (Vatican City State)'),
(99, 'HN', 'Honduras'),
(100, 'HK', 'Hong Kong'),
(101, 'HU', 'Hungary'),
(102, 'IS', 'Iceland'),
(103, 'IN', 'India'),
(104, 'ID', 'Indonesia'),
(105, 'IR', 'Iran, Islamic Republic of'),
(106, 'IQ', 'Iraq'),
(107, 'IE', 'Ireland'),
(108, 'IM', 'Isle of Man'),
(109, 'IL', 'Israel'),
(110, 'IT', 'Italy'),
(111, 'JM', 'Jamaica'),
(112, 'JP', 'Japan'),
(113, 'JE', 'Jersey'),
(114, 'JO', 'Jordan'),
(115, 'KZ', 'Kazakhstan'),
(116, 'KE', 'Kenya'),
(117, 'KI', 'Kiribati'),
(118, 'KP', 'Korea, Democratic People\'s Republic of'),
(119, 'KR', 'Korea, Republic of'),
(120, 'KW', 'Kuwait'),
(121, 'KG', 'Kyrgyzstan'),
(122, 'LA', 'Lao People\'s Democratic Republic'),
(123, 'LV', 'Latvia'),
(124, 'LB', 'Lebanon'),
(125, 'LS', 'Lesotho'),
(126, 'LR', 'Liberia'),
(127, 'LY', 'Libya'),
(128, 'LI', 'Liechtenstein'),
(129, 'LT', 'Lithuania'),
(130, 'LU', 'Luxembourg'),
(131, 'MO', 'Macao'),
(132, 'MK', 'Macedonia, the Former Yugoslav Republic of'),
(133, 'MG', 'Madagascar'),
(134, 'MW', 'Malawi'),
(135, 'MY', 'Malaysia'),
(136, 'MV', 'Maldives'),
(137, 'ML', 'Mali'),
(138, 'MT', 'Malta'),
(139, 'MH', 'Marshall Islands'),
(140, 'MQ', 'Martinique'),
(141, 'MR', 'Mauritania'),
(142, 'MU', 'Mauritius'),
(143, 'YT', 'Mayotte'),
(144, 'MX', 'Mexico'),
(145, 'FM', 'Micronesia, Federated States of'),
(146, 'MD', 'Moldova, Republic of'),
(147, 'MC', 'Monaco'),
(148, 'MN', 'Mongolia'),
(149, 'ME', 'Montenegro'),
(150, 'MS', 'Montserrat'),
(151, 'MA', 'Morocco'),
(152, 'MZ', 'Mozambique'),
(153, 'MM', 'Myanmar'),
(154, 'NA', 'Namibia'),
(155, 'NR', 'Nauru'),
(156, 'NP', 'Nepal'),
(157, 'NL', 'Netherlands'),
(158, 'NC', 'New Caledonia'),
(159, 'NZ', 'New Zealand'),
(160, 'NI', 'Nicaragua'),
(161, 'NE', 'Niger'),
(162, 'NG', 'Nigeria'),
(163, 'NU', 'Niue'),
(164, 'NF', 'Norfolk Island'),
(165, 'MP', 'Northern Mariana Islands'),
(166, 'NO', 'Norway'),
(167, 'OM', 'Oman'),
(168, 'PK', 'Pakistan'),
(169, 'PW', 'Palau'),
(170, 'PS', 'Palestine, State of'),
(171, 'PA', 'Panama'),
(172, 'PG', 'Papua New Guinea'),
(173, 'PY', 'Paraguay'),
(174, 'PE', 'Peru'),
(175, 'PH', 'Philippines'),
(176, 'PN', 'Pitcairn'),
(177, 'PL', 'Poland'),
(178, 'PT', 'Portugal'),
(179, 'PR', 'Puerto Rico'),
(180, 'QA', 'Qatar'),
(181, 'RE', 'Réunion'),
(182, 'RO', 'Romania'),
(183, 'RU', 'Russian Federation'),
(184, 'RW', 'Rwanda'),
(185, 'BL', 'Saint Barthélemy'),
(186, 'SH', 'Saint Helena, Ascension and Tristan da Cunha'),
(187, 'KN', 'Saint Kitts and Nevis'),
(188, 'LC', 'Saint Lucia'),
(189, 'MF', 'Saint Martin (French part)'),
(190, 'PM', 'Saint Pierre and Miquelon'),
(191, 'VC', 'Saint Vincent and the Grenadines'),
(192, 'WS', 'Samoa'),
(193, 'SM', 'San Marino'),
(194, 'ST', 'Sao Tome and Principe'),
(195, 'SA', 'Saudi Arabia'),
(196, 'SN', 'Senegal'),
(197, 'RS', 'Serbia'),
(198, 'SC', 'Seychelles'),
(199, 'SL', 'Sierra Leone'),
(200, 'SG', 'Singapore'),
(201, 'SX', 'Sint Maarten (Dutch part)'),
(202, 'SK', 'Slovakia'),
(203, 'SI', 'Slovenia'),
(204, 'SB', 'Solomon Islands'),
(205, 'SO', 'Somalia'),
(206, 'ZA', 'South Africa'),
(207, 'GS', 'South Georgia and the South Sandwich Islands'),
(208, 'SS', 'South Sudan'),
(209, 'ES', 'Spain'),
(210, 'LK', 'Sri Lanka'),
(211, 'SD', 'Sudan'),
(212, 'SR', 'Suriname'),
(213, 'SJ', 'Svalbard and Jan Mayen'),
(214, 'SZ', 'Swaziland'),
(215, 'SE', 'Sweden'),
(216, 'CH', 'Switzerland'),
(217, 'SY', 'Syrian Arab Republic'),
(218, 'TW', 'Taiwan'),
(219, 'TJ', 'Tajikistan'),
(220, 'TZ', 'Tanzania, United Republic of'),
(221, 'TH', 'Thailand'),
(222, 'TL', 'Timor-Leste'),
(223, 'TG', 'Togo'),
(224, 'TK', 'Tokelau'),
(225, 'TO', 'Tonga'),
(226, 'TT', 'Trinidad and Tobago'),
(227, 'TN', 'Tunisia'),
(228, 'TR', 'Turkey'),
(229, 'TM', 'Turkmenistan'),
(230, 'TC', 'Turks and Caicos Islands'),
(231, 'TV', 'Tuvalu'),
(232, 'UG', 'Uganda'),
(233, 'UA', 'Ukraine'),
(234, 'AE', 'United Arab Emirates'),
(235, 'GB', 'United Kingdom'),
(236, 'US', 'United States'),
(237, 'UM', 'United States Minor Outlying Islands'),
(238, 'UY', 'Uruguay'),
(239, 'UZ', 'Uzbekistan'),
(240, 'VU', 'Vanuatu'),
(241, 'VE', 'Venezuela, Bolivarian Republic of'),
(242, 'VN', 'Viet Nam'),
(243, 'VG', 'Virgin Islands, British'),
(244, 'VI', 'Virgin Islands, U.S.'),
(245, 'WF', 'Wallis and Futuna'),
(246, 'EH', 'Western Sahara'),
(247, 'YE', 'Yemen'),
(248, 'ZM', 'Zambia'),
(249, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`) VALUES
(1, 'Sales'),
(2, 'Management'),
(3, 'Technical Support'),
(4, 'Billing'),
(5, 'Customer Success'),
(6, 'Development');

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `html` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`id`, `name`, `details`, `slug`, `language`, `html`) VALUES
(1, 'Create ticket by new customer', 'When customer create a new ticket from the landing page', 'create_ticket_new_customer', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>Ticket mail</title>\n    <style>\n\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 5px;\n            padding-top: 5px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n            line-height: 1.4;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #7366ff;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #7366ff;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 6px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #7366ff;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #7366ff;\n            border-color: #7366ff;\n            color: #ffffff;\n        }\n\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        .mail-body .main{\n            background-image: url(\'https://res.cloudinary.com/robinbd/image/upload/v1663394450/mail-template/background-bottom.png\');\n            background-repeat: no-repeat;\n            background-size: 100%;\n            background-position: 50% 100%;\n        }\n        .gap-bottom{\n            padding-bottom: 10px;\n        }\n        .gap-top{\n            padding-top: 10px;\n        }\n\n        @media only screen and (max-width: 620px) {\n            table.mail-body h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            table.mail-body p,\n            table.mail-body ul,\n            table.mail-body ol,\n            table.mail-body td,\n            table.mail-body span,\n            table.mail-body a {\n                font-size: 16px !important;\n            }\n            table.mail-body .wrapper,\n            table.mail-body .article {\n                padding: 10px !important;\n            }\n            table.mail-body .content {\n                padding: 0 !important;\n            }\n            table.mail-body .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            table.mail-body .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            table.mail-body .btn table {\n                width: 100% !important;\n            }\n            table.mail-body .btn a {\n                width: 100% !important;\n            }\n            table.mail-body .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            #MessageViewBody a {\n                color: inherit;\n                text-decoration: none;\n                font-size: inherit;\n                font-family: inherit;\n                font-weight: inherit;\n                line-height: inherit;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body>\n<span class=\"preheader\">Helpdesk ticket update</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td></td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"header\">\n                            <a href=\"#\">\n                                <img style=\"height: 60px; width: auto; margin: 15px auto;display: block\" src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"help desk\" />\n                            </a>\n                        </td>\n                    </tr>\n                    <tr>\n                        <td class=\"wrapper\">\n\n                            <table role=\"presentation\" class=\"main-table\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <p>Hi {name},</p>\n                                        <p>A new ticket has been created. You would be able to login with the following credentials to review your ticket and following up continue process.</p>\n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                            <tbody>\n                                            <tr>\n                                                <td><strong>Ticket Number:</strong> {uid}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><strong>Email:</strong> {email}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><strong>Password:</strong> {password}</td>\n                                            </tr>\n                                            <tr>\n                                                <td class=\"gap-bottom\"> You would be able to login from the following url.</td>\n                                            </tr>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td class=\"btn btn-primary\"><a href=\"{url}\" target=\"_blank\">Login</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <p class=\"gap-top\">We will send you also different email regarding the ticket update but if you login on the system you would be able to discuss continue with manager regarding your ticket.</p>\n                                        <p>Thank you!</p>\n                                        <p>Best regards, <br/>{sender_name}</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">HelpDesk - A online ticket support system</span>\n                            </td>\n                        </tr>\n                        <tr>\n                            <td class=\"content-block powered-by\">\n                                © 2022 <a href=\"http://w3bd.com\">W3BD</a> - All rights reserved.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td></td>\n    </tr>\n</table>\n</body>\n</html>\n'),
(2, 'Create ticket from dashboard', 'When a ticket created from the admin page', 'create_ticket_dashboard', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>Ticket mail</title>\n    <style>\n\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 5px;\n            padding-top: 5px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n            line-height: 1.4;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #7366ff;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #7366ff;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 6px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #7366ff;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #7366ff;\n            border-color: #7366ff;\n            color: #ffffff;\n        }\n\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        .mail-body .main{\n            background-image: url(\'https://res.cloudinary.com/robinbd/image/upload/v1663394450/mail-template/background-bottom.png\');\n            background-repeat: no-repeat;\n            background-size: 100%;\n            background-position: 50% 100%;\n        }\n\n        @media only screen and (max-width: 620px) {\n            table.mail-body h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            table.mail-body p,\n            table.mail-body ul,\n            table.mail-body ol,\n            table.mail-body td,\n            table.mail-body span,\n            table.mail-body a {\n                font-size: 16px !important;\n            }\n            table.mail-body .wrapper,\n            table.mail-body .article {\n                padding: 10px !important;\n            }\n            table.mail-body .content {\n                padding: 0 !important;\n            }\n            table.mail-body .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            table.mail-body .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            table.mail-body .btn table {\n                width: 100% !important;\n            }\n            table.mail-body .btn a {\n                width: 100% !important;\n            }\n            table.mail-body .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            #MessageViewBody a {\n                color: inherit;\n                text-decoration: none;\n                font-size: inherit;\n                font-family: inherit;\n                font-weight: inherit;\n                line-height: inherit;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body>\n<span class=\"preheader\">Helpdesk ticket update</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td></td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"header\">\n                            <a href=\"#\">\n                                <img style=\"height: 60px; width: auto; margin: 15px auto;display: block\" src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"help desk\" />\n                            </a>\n                        </td>\n                    </tr>\n                    <tr>\n                        <td class=\"wrapper\">\n\n                            <table role=\"presentation\" class=\"main-table\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <p>Hi {name},</p>\n                                        <p>A new ticket has been created. You would be able to review the ticket and following up continue process from the following link.</p>\n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"btn btn-primary\">\n                                            <tbody>\n                                            <tr>\n                                                <td><strong>Ticket number:</strong> {uid}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><strong>Subject:</strong> {subject}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><strong>Ticket type:</strong> {type}</td>\n                                            </tr>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td><a href=\"{url}\" target=\"_blank\">View ticket</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <p>We will send you also different email regarding the ticket update but if you login on the system you would be able to discuss continue with manager regarding your ticket.</p>\n                                        <p>Thank you!</p>\n                                        <p>Best regards, <br/>{sender_name}</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">HelpDesk - A online ticket support system</span>\n                            </td>\n                        </tr>\n                        <tr>\n                            <td class=\"content-block powered-by\">\n                                © 2022 <a href=\"http://w3bd.com\">W3BD</a> - All rights reserved.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td></td>\n    </tr>\n</table>\n</body>\n</html>\n'),
(3, 'Custom Mail', 'It will use to send any custom email.', 'custom_mail', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>Event mail</title>\n    <style>\n\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 5px;\n            padding-top: 5px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n            line-height: 1.4;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #7366ff;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #7366ff;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 6px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #7366ff;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #7366ff;\n            border-color: #7366ff;\n            color: #ffffff;\n        }\n\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        .mail-body .main{\n            background-image: url(\'https://res.cloudinary.com/robinbd/image/upload/v1663394450/mail-template/background-bottom.png\');\n            background-repeat: no-repeat;\n            background-size: 100%;\n            background-position: 50% 100%;\n        }\n\n        @media only screen and (max-width: 620px) {\n            table.mail-body h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            table.mail-body p,\n            table.mail-body ul,\n            table.mail-body ol,\n            table.mail-body td,\n            table.mail-body span,\n            table.mail-body a {\n                font-size: 16px !important;\n            }\n            table.mail-body .wrapper,\n            table.mail-body .article {\n                padding: 10px !important;\n            }\n            table.mail-body .content {\n                padding: 0 !important;\n            }\n            table.mail-body .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            table.mail-body .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            table.mail-body .btn table {\n                width: 100% !important;\n            }\n            table.mail-body .btn a {\n                width: 100% !important;\n            }\n            table.mail-body .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            #MessageViewBody a {\n                color: inherit;\n                text-decoration: none;\n                font-size: inherit;\n                font-family: inherit;\n                font-weight: inherit;\n                line-height: inherit;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body>\n<span class=\"preheader\">ProSchedule</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td></td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"header\">\n                            <a href=\"#\">\n                                <img style=\"height: 60px; width: auto; margin: 15px auto;display: block\" src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"help desk\" />\n                            </a>\n                        </td>\n                    </tr>\n                    <tr>\n                        <td class=\"wrapper\">\n\n                            <table role=\"presentation\" class=\"main-table\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <p>Hi {name},</p>\n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"\">\n                                            <tbody>\n                                            <tr>\n                                                <td>\n                                                    {body}\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <p>Best regards, <br/>{sender_name}</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">ProSchedule - A online ticket support system</span>\n                            </td>\n                        </tr>\n                        <tr>\n                            <td class=\"content-block powered-by\">\n                                © 2022 <a href=\"http://w3bd.com\">W3BD</a> - All rights reserved.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td></td>\n    </tr>\n</table>\n</body>\n</html>\n');
INSERT INTO `email_templates` (`id`, `name`, `details`, `slug`, `language`, `html`) VALUES
(4, 'Got assigned for a ticket', 'When a user got assigned for a ticket.', 'assigned_ticket', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>Ticket mail</title>\n    <style>\n\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 5px;\n            padding-top: 5px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n            line-height: 1.4;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #7366ff;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #7366ff;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 6px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #7366ff;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #7366ff;\n            border-color: #7366ff;\n            color: #ffffff;\n        }\n\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        .mail-body .main{\n            background-image: url(\'https://res.cloudinary.com/robinbd/image/upload/v1663394450/mail-template/background-bottom.png\');\n            background-repeat: no-repeat;\n            background-size: 100%;\n            background-position: 50% 100%;\n        }\n        .gap-bottom{\n            padding-bottom: 10px;\n        }\n        .gap-top{\n            padding-top: 10px;\n        }\n\n        @media only screen and (max-width: 620px) {\n            table.mail-body h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            table.mail-body p,\n            table.mail-body ul,\n            table.mail-body ol,\n            table.mail-body td,\n            table.mail-body span,\n            table.mail-body a {\n                font-size: 16px !important;\n            }\n            table.mail-body .wrapper,\n            table.mail-body .article {\n                padding: 10px !important;\n            }\n            table.mail-body .content {\n                padding: 0 !important;\n            }\n            table.mail-body .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            table.mail-body .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            table.mail-body .btn table {\n                width: 100% !important;\n            }\n            table.mail-body .btn a {\n                width: 100% !important;\n            }\n            table.mail-body .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            #MessageViewBody a {\n                color: inherit;\n                text-decoration: none;\n                font-size: inherit;\n                font-family: inherit;\n                font-weight: inherit;\n                line-height: inherit;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body>\n<span class=\"preheader\">Helpdesk ticket update</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td></td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"header\">\n                            <a href=\"#\">\n                                <img style=\"height: 60px; width: auto; margin: 15px auto;display: block\" src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"help desk\" />\n                            </a>\n                        </td>\n                    </tr>\n                    <tr>\n                        <td class=\"wrapper\">\n\n                            <table role=\"presentation\" class=\"main-table\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <p>Hi {name},</p>\n                                        <p>You got assigned a new ticket. The following is the ticket info, you would be able to see in details with visiting the ticket link.</p>\n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                            <tbody>\n                                            <tr>\n                                                <td><strong>Ticket number:</strong> {uid}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><strong>Subject:</strong> {subject}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><strong>Ticket type:</strong> {type}</td>\n                                            </tr>\n                                            <tr>\n                                                <td class=\"gap-bottom\"> You would be able view the ticket from the following link.</td>\n                                            </tr>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td class=\"btn btn-primary\"><a href=\"{url}\" target=\"_blank\">View Ticket</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <p class=\"gap-top\">We will send you also different email regarding the ticket update but if you login on the system you would be able to discuss continue with users who are associate with the ticket.</p>\n                                        <p>Thank you!</p>\n                                        <p>Best regards, <br/>{sender_name}</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">HelpDesk - A online ticket support system</span>\n                            </td>\n                        </tr>\n                        <tr>\n                            <td class=\"content-block powered-by\">\n                                © 2022 <a href=\"http://w3bd.com\">W3BD</a> - All rights reserved.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td></td>\n    </tr>\n</table>\n</body>\n</html>\n'),
(5, 'The ticket has been updated', 'When a ticket has been updated.', 'ticket_updated', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>Ticket mail</title>\n    <style>\n\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table.bordered_table{\n            border-collapse: collapse;\n            width: 100%;\n            margin-bottom: 10px;\n        }\n        .mail-body table.bordered_table th, .mail-body table.bordered_table td{\n            border: 1px solid #ddd;\n            padding: 8px;\n        }\n        .mail-body table td b{\n            font-weight: 600;\n        }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 5px;\n            padding-top: 5px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n            line-height: 1.4;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #7366ff;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #7366ff;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 6px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #7366ff;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #7366ff;\n            border-color: #7366ff;\n            color: #ffffff;\n        }\n\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        .mail-body .main{\n            background-image: url(\'https://res.cloudinary.com/robinbd/image/upload/v1663394450/mail-template/background-bottom.png\');\n            background-repeat: no-repeat;\n            background-size: 100%;\n            background-position: 50% 100%;\n        }\n        .gap-bottom{\n            padding-bottom: 10px;\n        }\n        .gap-top{\n            padding-top: 10px;\n        }\n\n        @media only screen and (max-width: 620px) {\n            table.mail-body h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            table.mail-body p,\n            table.mail-body ul,\n            table.mail-body ol,\n            table.mail-body td,\n            table.mail-body span,\n            table.mail-body a {\n                font-size: 16px !important;\n            }\n            table.mail-body .wrapper,\n            table.mail-body .article {\n                padding: 10px !important;\n            }\n            table.mail-body .content {\n                padding: 0 !important;\n            }\n            table.mail-body .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            table.mail-body .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            table.mail-body .btn table {\n                width: 100% !important;\n            }\n            table.mail-body .btn a {\n                width: 100% !important;\n            }\n            table.mail-body .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            #MessageViewBody a {\n                color: inherit;\n                text-decoration: none;\n                font-size: inherit;\n                font-family: inherit;\n                font-weight: inherit;\n                line-height: inherit;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body>\n<span class=\"preheader\">Helpdesk ticket update</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td></td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"header\">\n                            <a href=\"#\">\n                                <img style=\"height: 60px; width: auto; margin: 15px auto;display: block\" src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"help desk\" />\n                            </a>\n                        </td>\n                    </tr>\n                    <tr>\n                        <td class=\"wrapper\">\n\n                            <table role=\"presentation\" class=\"main-table\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <p>Hi {name},</p>\n                                        <p>{update_message} The following is the ticket info, you would be able to see in details with visiting the ticket link.</p>\n                                        <table class=\"bordered_table\">\n                                            <tbody>\n                                            <tr>\n                                                <td><b>Ticket number:</b></td>\n                                                <td>{uid}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><b>Subject:</b></td>\n                                                <td>{subject}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><b>Priority:</b></td>\n                                                <td>{priority}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><b>Status:</b></td>\n                                                <td>{status}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><b>Ticket type:</b></td>\n                                                <td>{type}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><b>Department:</b></td>\n                                                <td>{department}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><b>Category:</b></td>\n                                                <td>{category}</td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                            <tbody>\n                                            <tr>\n                                                <td class=\"gap-bottom\"> You would be able view the ticket from the following link.</td>\n                                            </tr>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td class=\"btn btn-primary\"><a href=\"{url}\" target=\"_blank\">View Ticket</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <p class=\"gap-top\">We will send you also different email regarding the ticket update but if you login on the system you would be able to discuss continue with users who are associate with the ticket.</p>\n                                        <p>Thank you!</p>\n                                        <p>Best regards, <br/>{sender_name}</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">HelpDesk - A online ticket support system</span>\n                            </td>\n                        </tr>\n                        <tr>\n                            <td class=\"content-block powered-by\">\n                                © 2022 <a href=\"http://w3bd.com\">W3BD</a> - All rights reserved.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td></td>\n    </tr>\n</table>\n</body>\n</html>\n'),
(6, 'A new comment has been added on the ticket', 'When a comment has been added on a ticket.', 'ticket_new_comment', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>Ticket mail</title>\n    <style>\n\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 5px;\n            padding-top: 5px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n            line-height: 1.4;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #7366ff;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #7366ff;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 6px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #7366ff;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #7366ff;\n            border-color: #7366ff;\n            color: #ffffff;\n        }\n\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        .mail-body .main{\n            background-image: url(\'https://res.cloudinary.com/robinbd/image/upload/v1663394450/mail-template/background-bottom.png\');\n            background-repeat: no-repeat;\n            background-size: 100%;\n            background-position: 50% 100%;\n        }\n        .gap-bottom{\n            padding-bottom: 10px;\n        }\n        .gap-top{\n            padding-top: 10px;\n        }\n\n        @media only screen and (max-width: 620px) {\n            table.mail-body h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            table.mail-body p,\n            table.mail-body ul,\n            table.mail-body ol,\n            table.mail-body td,\n            table.mail-body span,\n            table.mail-body a {\n                font-size: 16px !important;\n            }\n            table.mail-body .wrapper,\n            table.mail-body .article {\n                padding: 10px !important;\n            }\n            table.mail-body .content {\n                padding: 0 !important;\n            }\n            table.mail-body .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            table.mail-body .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            table.mail-body .btn table {\n                width: 100% !important;\n            }\n            table.mail-body .btn a {\n                width: 100% !important;\n            }\n            table.mail-body .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            #MessageViewBody a {\n                color: inherit;\n                text-decoration: none;\n                font-size: inherit;\n                font-family: inherit;\n                font-weight: inherit;\n                line-height: inherit;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body>\n<span class=\"preheader\">Helpdesk ticket update</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td></td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"header\">\n                            <a href=\"#\">\n                                <img style=\"height: 60px; width: auto; margin: 15px auto;display: block\" src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"help desk\" />\n                            </a>\n                        </td>\n                    </tr>\n                    <tr>\n                        <td class=\"wrapper\">\n\n                            <table role=\"presentation\" class=\"main-table\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <p>Hi {name},</p>\n                                        <p>A new comment has been added on the ticket.</p>\n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                            <tbody>\n                                            <tr>\n                                                <td><strong>Ticket number:</strong> {uid}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><strong>Comment:</strong> {comment}</td>\n                                            </tr>\n                                            <tr>\n                                                <td class=\"gap-bottom gap-top\"> You would be able view the ticket from the following link.</td>\n                                            </tr>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td class=\"btn btn-primary\"><a href=\"{url}\" target=\"_blank\">View Ticket</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <p class=\"gap-top\">We will send you also different email regarding the ticket update but if you login on the system you would be able to discuss continue with users who are associate with the ticket.</p>\n                                        <p>Thank you!</p>\n                                        <p>Best regards, <br/>{sender_name}</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">HelpDesk - A online ticket support system</span>\n                            </td>\n                        </tr>\n                        <tr>\n                            <td class=\"content-block powered-by\">\n                                © 2022 <a href=\"http://w3bd.com\">W3BD</a> - All rights reserved.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td></td>\n    </tr>\n</table>\n</body>\n</html>\n');
INSERT INTO `email_templates` (`id`, `name`, `details`, `slug`, `language`, `html`) VALUES
(7, 'User created', 'When a new user created.', 'user_created', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>User Created mail</title>\n    <style>\n\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body table.bordered_table{\n            border-collapse: collapse;\n            width: 100%;\n            margin-bottom: 10px;\n        }\n        .mail-body table.bordered_table th, .mail-body table.bordered_table td{\n            border: 1px solid #ddd;\n            padding: 8px;\n        }\n        .mail-body table td b{\n            font-weight: 600;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 5px;\n            padding-top: 5px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n            line-height: 1.4;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #7366ff;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #7366ff;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 6px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #7366ff;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #7366ff;\n            border-color: #7366ff;\n            color: #ffffff;\n        }\n\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        .mail-body .main{\n            background-image: url(\'https://res.cloudinary.com/robinbd/image/upload/v1663394450/mail-template/background-bottom.png\');\n            background-repeat: no-repeat;\n            background-size: 100%;\n            background-position: 50% 100%;\n        }\n        .gap-bottom{\n            padding-bottom: 10px;\n        }\n        .gap-top{\n            padding-top: 10px;\n        }\n\n        @media only screen and (max-width: 620px) {\n            table.mail-body h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            table.mail-body p,\n            table.mail-body ul,\n            table.mail-body ol,\n            table.mail-body td,\n            table.mail-body span,\n            table.mail-body a {\n                font-size: 16px !important;\n            }\n            table.mail-body .wrapper,\n            table.mail-body .article {\n                padding: 10px !important;\n            }\n            table.mail-body .content {\n                padding: 0 !important;\n            }\n            table.mail-body .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            table.mail-body .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            table.mail-body .btn table {\n                width: 100% !important;\n            }\n            table.mail-body .btn a {\n                width: 100% !important;\n            }\n            table.mail-body .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            #MessageViewBody a {\n                color: inherit;\n                text-decoration: none;\n                font-size: inherit;\n                font-family: inherit;\n                font-weight: inherit;\n                line-height: inherit;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body>\n<span class=\"preheader\">Helpdesk ticket update</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td></td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"header\">\n                            <a href=\"#\">\n                                <img style=\"height: 60px; width: auto; margin: 15px auto;display: block\" src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"help desk\" />\n                            </a>\n                        </td>\n                    </tr>\n                    <tr>\n                        <td class=\"wrapper\">\n\n                            <table role=\"presentation\" class=\"main-table\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <p>Hi {name},</p>\n                                        <p>Your HelpDesk account has been created. The following is the credentials for your account.</p>\n                                        <table class=\"bordered_table\">\n                                            <tbody>\n                                            <tr>\n                                                <td><b>Login email</b></td>\n                                                <td>{email}</td>\n                                            </tr>\n                                            <tr>\n                                                <td><b>Password</b></td>\n                                                <td>{password}</td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                            <tbody>\n                                            <tr>\n                                                <td class=\"gap-bottom\"> You would be able login on the dashboard from the following link.</td>\n                                            </tr>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td class=\"btn btn-primary\"><a href=\"{url}\" target=\"_blank\">Login</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        <p class=\"gap-top\">Enjoy the features of HelpDesk.</p>\n                                        <p>Thank you!</p>\n                                        <p>Best regards, <br/>{sender_name}</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">HelpDesk - A online ticket support system</span>\n                            </td>\n                        </tr>\n                        <tr>\n                            <td class=\"content-block powered-by\">\n                                © 2022 <a href=\"http://w3bd.com\">W3BD</a> - All rights reserved.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td></td>\n    </tr>\n</table>\n</body>\n</html>\n'),
(8, 'Conversation Created', 'When a new conversation is created and user is added as participant.', 'conversation_created', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>Conversation Created</title>\n    <style>\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 10px;\n            padding-top: 10px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #3498db;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #3498db;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 12px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #3498db;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #3498db;\n            border-color: #3498db;\n            color: #ffffff;\n        }\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .text-link {\n            color: #3498db !important;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        @media only screen and (max-width: 620px) {\n            .mail-body table[class=body] h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            .mail-body table[class=body] p,\n            .mail-body table[class=body] ul,\n            .mail-body table[class=body] ol,\n            .mail-body table[class=body] td,\n            .mail-body table[class=body] span,\n            .mail-body table[class=body] a {\n                font-size: 16px !important;\n            }\n            .mail-body table[class=body] .wrapper,\n            .mail-body table[class=body] .article {\n                padding: 10px !important;\n            }\n            .mail-body table[class=body] .content {\n                padding: 0 !important;\n            }\n            .mail-body table[class=body] .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            .mail-body table[class=body] .btn table {\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .btn a {\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body class=\"\">\n<span class=\"preheader\">You\'ve been added to a new conversation</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td>&nbsp;</td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"wrapper\">\n                            <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <img src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"Logo\" style=\"margin: 0 auto; display: block; max-width: 200px;\">\n                                        <h1>New Conversation Created</h1>\n                                        <p>Hello {{user_name}},</p>\n                                        <p>You have been added to a new {{conversation_type}} conversation.</p>\n                                        \n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"btn btn-primary\">\n                                            <tbody>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td> <a href=\"{{conversation_url}}\" target=\"_blank\">View Conversation</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        \n                                        <p><strong>Conversation Details:</strong></p>\n                                        <ul>\n                                            <li><strong>Type:</strong> {{conversation_type}}</li>\n                                            <li><strong>Ticket:</strong> #{{ticket_uid}} - {{ticket_subject}}</li>\n                                            <li><strong>Created by:</strong> {{creator_name}}</li>\n                                        </ul>\n                                        \n                                        <p>You can now participate in this conversation and collaborate with other team members.</p>\n                                        \n                                        <p>Best regards,<br>{{app_name}} Team</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">{{app_name}} - Help Desk System</span>\n                                <br> This is an automated notification. Please do not reply to this email.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td>&nbsp;</td>\n    </tr>\n</table>\n</body>\n</html>\n\n\n\n\n\n'),
(9, 'New Message in Conversation', 'When a new message is sent in a conversation.', 'conversation_new_message', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>New Message in Conversation</title>\n    <style>\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 10px;\n            padding-top: 10px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #3498db;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #3498db;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 12px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #3498db;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #3498db;\n            border-color: #3498db;\n            color: #ffffff;\n        }\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .text-link {\n            color: #3498db !important;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        .message-preview {\n            background-color: #f8f9fa;\n            border-left: 4px solid #3498db;\n            padding: 15px;\n            margin: 15px 0;\n            border-radius: 4px;\n        }\n\n        @media only screen and (max-width: 620px) {\n            .mail-body table[class=body] h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            .mail-body table[class=body] p,\n            .mail-body table[class=body] ul,\n            .mail-body table[class=body] ol,\n            .mail-body table[class=body] td,\n            .mail-body table[class=body] span,\n            .mail-body table[class=body] a {\n                font-size: 16px !important;\n            }\n            .mail-body table[class=body] .wrapper,\n            .mail-body table[class=body] .article {\n                padding: 10px !important;\n            }\n            .mail-body table[class=body] .content {\n                padding: 0 !important;\n            }\n            .mail-body table[class=body] .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            .mail-body table[class=body] .btn table {\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .btn a {\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body class=\"\">\n<span class=\"preheader\">New message from {{sender_name}}</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td>&nbsp;</td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"wrapper\">\n                            <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <img src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"Logo\" style=\"margin: 0 auto; display: block; max-width: 200px;\">\n                                        <h1>New Message in Conversation</h1>\n                                        <p>Hello {{user_name}},</p>\n                                        <p>You have received a new message in a {{conversation_type}} conversation.</p>\n                                        \n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"btn btn-primary\">\n                                            <tbody>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td> <a href=\"{{conversation_url}}\" target=\"_blank\">View Conversation</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        \n                                        <p><strong>Message Details:</strong></p>\n                                        <ul>\n                                            <li><strong>From:</strong> {{sender_name}}</li>\n                                            <li><strong>Ticket:</strong> #{{ticket_uid}} - {{ticket_subject}}</li>\n                                            <li><strong>Conversation Type:</strong> {{conversation_type}}</li>\n                                        </ul>\n                                        \n                                        <div class=\"message-preview\">\n                                            <p><strong>Message Preview:</strong></p>\n                                            <p><em>\"{{message_preview}}\"</em></p>\n                                        </div>\n                                        \n                                        <p>Click the button above to view the full conversation and reply.</p>\n                                        \n                                        <p>Best regards,<br>{{app_name}} Team</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">{{app_name}} - Help Desk System</span>\n                                <br> This is an automated notification. Please do not reply to this email.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td>&nbsp;</td>\n    </tr>\n</table>\n</body>\n</html>\n\n\n\n\n\n');
INSERT INTO `email_templates` (`id`, `name`, `details`, `slug`, `language`, `html`) VALUES
(10, 'Added to Conversation', 'When a user is added to an existing conversation.', 'conversation_participant_added', 'en', '<!doctype html>\n<html>\n<head>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n    <title>Added to Conversation</title>\n    <style>\n        .mail-body img {\n            border: none;\n            -ms-interpolation-mode: bicubic;\n            max-width: 100%;\n        }\n\n        body {\n            background-color: #f6f6f6;\n        }\n\n        .mail-body table {\n            border-collapse: separate;\n            mso-table-lspace: 0pt;\n            mso-table-rspace: 0pt;\n            width: 100%; }\n        .mail-body table td {\n            font-family: sans-serif;\n            font-size: 14px;\n            vertical-align: top;\n        }\n        .mail-body {\n            background-color: #f6f6f6;\n            width: 100%;\n            font-size: 14px;\n            font-family: sans-serif;\n            -webkit-font-smoothing: antialiased;\n            line-height: 1.4;\n            margin: 0;\n            padding: 0;\n            -ms-text-size-adjust: 100%;\n            -webkit-text-size-adjust: 100%;\n        }\n\n        .mail-body .container {\n            display: block;\n            margin: 0 auto !important;\n            /* makes it centered */\n            max-width: 580px;\n            padding: 10px;\n            width: 580px;\n        }\n\n        .mail-body .content {\n            box-sizing: border-box;\n            display: block;\n            margin: 0 auto;\n            max-width: 580px;\n            padding: 10px;\n        }\n\n        .mail-body .main {\n            background: #ffffff;\n            border-radius: 3px;\n            width: 100%;\n        }\n\n        .mail-body .wrapper {\n            box-sizing: border-box;\n            padding: 20px;\n        }\n\n        .mail-body .content-block {\n            padding-bottom: 10px;\n            padding-top: 10px;\n        }\n\n        .mail-body .footer {\n            clear: both;\n            margin-top: 10px;\n            text-align: center;\n            width: 100%;\n        }\n        .mail-body .footer td,\n        .mail-body .footer p,\n        .mail-body .footer span,\n        .mail-body .footer a {\n            color: #999999;\n            font-size: 12px;\n            text-align: center;\n        }\n\n        .mail-body h1,\n        .mail-body h2,\n        .mail-body h3,\n        .mail-body h4 {\n            color: #000000;\n            font-family: sans-serif;\n            font-weight: 400;\n            line-height: 1.4;\n            margin: 0;\n            margin-bottom: 30px;\n        }\n\n        .mail-body h1 {\n            font-size: 35px;\n            font-weight: 300;\n            text-align: center;\n            text-transform: capitalize;\n        }\n\n        .mail-body p,\n        .mail-body ul,\n        .mail-body ol {\n            font-family: sans-serif;\n            font-size: 14px;\n            font-weight: normal;\n            margin: 0;\n            margin-bottom: 15px;\n        }\n        .mail-body p li,\n        .mail-body ul li,\n        .mail-body ol li {\n            list-style-position: inside;\n            margin-left: 5px;\n        }\n\n        .mail-body .btn {\n            box-sizing: border-box;\n            width: 100%; }\n        .mail-body .btn > tbody > tr > td {\n            padding-bottom: 15px; }\n        .mail-body .btn table {\n            width: auto;\n        }\n        .mail-body .btn table td {\n            background-color: #ffffff;\n            border-radius: 5px;\n            text-align: center;\n        }\n        .mail-body .btn a {\n            background-color: #ffffff;\n            border: solid 1px #3498db;\n            border-radius: 5px;\n            box-sizing: border-box;\n            color: #3498db;\n            cursor: pointer;\n            display: inline-block;\n            font-size: 14px;\n            font-weight: bold;\n            margin: 0;\n            padding: 12px 25px;\n            text-decoration: none;\n            text-transform: capitalize;\n        }\n\n        .mail-body .btn-primary table td {\n            background-color: #3498db;\n        }\n\n        .mail-body .btn-primary a {\n            background-color: #3498db;\n            border-color: #3498db;\n            color: #ffffff;\n        }\n\n        .mail-body .last {\n            margin-bottom: 0;\n        }\n\n        .mail-body .first {\n            margin-top: 0;\n        }\n\n        .mail-body .align-center {\n            text-align: center;\n        }\n\n        .mail-body .align-right {\n            text-align: right;\n        }\n\n        .mail-body .align-left {\n            text-align: left;\n        }\n\n        .mail-body .text-link {\n            color: #3498db !important;\n        }\n\n        .mail-body .clear {\n            clear: both;\n        }\n\n        .mail-body .mt0 {\n            margin-top: 0;\n        }\n\n        .mail-body .mb0 {\n            margin-bottom: 0;\n        }\n\n        .preheader {\n            color: transparent;\n            display: none;\n            height: 0;\n            max-height: 0;\n            max-width: 0;\n            opacity: 0;\n            overflow: hidden;\n            mso-hide: all;\n            visibility: hidden;\n            width: 0;\n        }\n\n        .mail-body .powered-by a {\n            text-decoration: none;\n        }\n\n        .mail-body hr {\n            border: 0;\n            border-bottom: 1px solid #f6f6f6;\n            margin: 20px 0;\n        }\n\n        @media only screen and (max-width: 620px) {\n            .mail-body table[class=body] h1 {\n                font-size: 28px !important;\n                margin-bottom: 10px !important;\n            }\n            .mail-body table[class=body] p,\n            .mail-body table[class=body] ul,\n            .mail-body table[class=body] ol,\n            .mail-body table[class=body] td,\n            .mail-body table[class=body] span,\n            .mail-body table[class=body] a {\n                font-size: 16px !important;\n            }\n            .mail-body table[class=body] .wrapper,\n            .mail-body table[class=body] .article {\n                padding: 10px !important;\n            }\n            .mail-body table[class=body] .content {\n                padding: 0 !important;\n            }\n            .mail-body table[class=body] .container {\n                padding: 0 !important;\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .main {\n                border-left-width: 0 !important;\n                border-radius: 0 !important;\n                border-right-width: 0 !important;\n            }\n            .mail-body table[class=body] .btn table {\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .btn a {\n                width: 100% !important;\n            }\n            .mail-body table[class=body] .img-responsive {\n                height: auto !important;\n                max-width: 100% !important;\n                width: auto !important;\n            }\n        }\n\n        @media all {\n            .mail-body .ExternalClass {\n                width: 100%;\n            }\n            .mail-body .ExternalClass,\n            .mail-body .ExternalClass p,\n            .mail-body .ExternalClass span,\n            .mail-body .ExternalClass font,\n            .mail-body .ExternalClass td,\n            .mail-body .ExternalClass div {\n                line-height: 100%;\n            }\n            .mail-body .apple-link a {\n                color: inherit !important;\n                font-family: inherit !important;\n                font-size: inherit !important;\n                font-weight: inherit !important;\n                line-height: inherit !important;\n                text-decoration: none !important;\n            }\n            .mail-body .btn-primary table td:hover {\n                background-color: #34495e !important;\n            }\n            .mail-body .btn-primary a:hover {\n                background-color: #34495e !important;\n                border-color: #34495e !important;\n            }\n        }\n\n    </style>\n</head>\n<body class=\"\">\n<span class=\"preheader\">You\'ve been added to a conversation by {{added_by_name}}</span>\n<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mail-body\">\n    <tr>\n        <td>&nbsp;</td>\n        <td class=\"container\">\n            <div class=\"content\">\n\n                <!-- START CENTERED WHITE CONTAINER -->\n                <table role=\"presentation\" class=\"main\">\n\n                    <!-- START MAIN CONTENT AREA -->\n                    <tr>\n                        <td class=\"wrapper\">\n                            <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                <tr>\n                                    <td>\n                                        <img src=\"http://sodhelpdesk.local/images/logo.png\" alt=\"Logo\" style=\"margin: 0 auto; display: block; max-width: 200px;\">\n                                        <h1>Added to Conversation</h1>\n                                        <p>Hello {{user_name}},</p>\n                                        <p>You have been added to a {{conversation_type}} conversation by {{added_by_name}}.</p>\n                                        \n                                        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"btn btn-primary\">\n                                            <tbody>\n                                            <tr>\n                                                <td align=\"left\">\n                                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                                        <tbody>\n                                                        <tr>\n                                                            <td> <a href=\"{{conversation_url}}\" target=\"_blank\">Join Conversation</a> </td>\n                                                        </tr>\n                                                        </tbody>\n                                                    </table>\n                                                </td>\n                                            </tr>\n                                            </tbody>\n                                        </table>\n                                        \n                                        <p><strong>Conversation Details:</strong></p>\n                                        <ul>\n                                            <li><strong>Type:</strong> {{conversation_type}}</li>\n                                            <li><strong>Ticket:</strong> #{{ticket_uid}} - {{ticket_subject}}</li>\n                                            <li><strong>Added by:</strong> {{added_by_name}}</li>\n                                        </ul>\n                                        \n                                        <p>You can now participate in this conversation and collaborate with other team members.</p>\n                                        \n                                        <p>Best regards,<br>{{app_name}} Team</p>\n                                    </td>\n                                </tr>\n                            </table>\n                        </td>\n                    </tr>\n\n                    <!-- END MAIN CONTENT AREA -->\n                </table>\n                <!-- END CENTERED WHITE CONTAINER -->\n\n                <!-- START FOOTER -->\n                <div class=\"footer\">\n                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                            <td class=\"content-block\">\n                                <span class=\"apple-link\">{{app_name}} - Help Desk System</span>\n                                <br> This is an automated notification. Please do not reply to this email.\n                            </td>\n                        </tr>\n                    </table>\n                </div>\n                <!-- END FOOTER -->\n\n            </div>\n        </td>\n        <td>&nbsp;</td>\n    </tr>\n</table>\n</body>\n</html>\n\n\n\n\n\n');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `front_pages`
--

CREATE TABLE `front_pages` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` int DEFAULT '1',
  `html` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `front_pages`
--

INSERT INTO `front_pages` (`id`, `title`, `slug`, `is_active`, `html`, `created_at`, `updated_at`) VALUES
(1, 'Privacy', 'privacy', 1, '{\"title\": \"Privacy Policy\", \"content\": \"<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.</p><p>&nbsp;</p><h2><strong>Collection of personal information</strong></h2><p>We receive and store any information you knowingly provide to us when you make a purchase through the Website. Currently this is limited to your email address, which is required for you to be able to login to the Website and access any purchased Tailwind UI products.</p><h2><strong>Collection of non-personal information</strong></h2><p>When you visit the Website our servers automatically record information that your browser sends. This data may include information such as your device\'s IP address, browser type and version, operating system type and version, language preferences or the webpage you were visiting before you came to our Website, pages of our Website that you visit, the time spent on those pages, information you search for on our Website, access times and dates, and other statistics.</p><h2><strong>Purchases</strong></h2><p>All purchases made through the Website are processed by a third party payment processor, Paddle (<a href=\\\"https://paddle.com/\\\"><strong>paddle.com</strong></a>). Paddle may ask you for personal and/or non-personal information, such as your name, address, email address, credit card information, or other Personal Information. Paddle has a privacy policy (<a href=\\\"https://paddle.com/legal-buyers/\\\"><strong>paddle.com/legal-buyers/</strong></a>) that describes their collection and use of personal information. Tailwind does not control Paddle or its collection or use of information. Any questions or concerns about Paddle’s practices should be directed to Paddle.</p><p>Paddle provides us with certain non-personal information relating to purchases made by visitors to the Website. The non-personal information may include details of the purchase such as the date, amount paid, and product purchased. The non-personal purchase information may be linked to the Personal Information you provide to us (typically limited to your email address, as stated above). Paddle does not supply us with any of your other Personal Information such as your name, street address, or credit card information.</p><h2><strong>Managing personal information</strong></h2><p>You are able to update your Personal Information in your \\\"Account Settings\\\" on the Website. Currently this is limited to just your email address, as described above. You may also request that we delete your email address, but this will prevent you from accessing the products you have purchased from Tailwind.</p><p>When you update information, we may maintain a copy of the unrevised information in our records. Some information may remain in our private records after deletion of such information from your account for a retention period. Once the retention period expires, Personal Information shall be deleted. Therefore, the right to access, the right to erasure, your rights to access, add to, and update your information cannot be enforced after the expiration of the retention period.</p><p>We will retain and use your information as necessary to comply with our legal obligations, resolve disputes, and enforce our agreements. We may use any aggregated data derived from or incorporating your Personal Information after you update or delete it, but not in a manner that would identify you personally.</p><h2><strong>Use and processing of collected information</strong></h2><p>Any of the information we collect from you may be used to personalize your experience; improve our Website; improve customer service; process transactions; send notification emails such as password reminders, updates, etc; and operate our Website. Non-Personal Information collected is used only to identify potential cases of abuse and establish statistical information regarding Website usage. This statistical information is not otherwise aggregated in such a way that would identify any particular user of the system.</p><p>We may process Personal Information related to you if one of the following applies: (i) You have given their consent for one or more specific purposes. Note that under some legislations we may be allowed to process information until you object to such processing (by opting out), without having to rely on consent or any other of the following legal bases below. This, however, does not apply, whenever the processing of Personal Information is subject to European data protection law; (ii) Provision of information is necessary for the performance of an agreement with you and/or for any pre-contractual obligations thereof; (ii) Processing is necessary for compliance with a legal obligation to which you are subject; (iv) Processing is related to a task that is carried out in the public interest or in the exercise of official authority vested in us; (v) Processing is necessary for the purposes of the legitimate interests pursued by us or by a third party. In any case, we will be happy to clarify the specific legal basis that applies to the processing, and in particular whether the provision of Personal Data is a statutory or contractual requirement, or a requirement necessary to enter into a contract.</p><h2><strong>Information transfer and storage</strong></h2><p>Depending on your location, data transfers may involve transferring and storing your information in a country other than your own. You are entitled to learn about the legal basis of information transfers to a country outside the European Union or to any international organization governed by public international law or set up by two or more countries, such as the UN, and about the security measures taken by us to safeguard your information. If any such transfer takes place, you can find out more by checking the relevant sections of this document or inquire with us using the information provided in the Contact section.</p><h2><strong>The rights of users</strong></h2><p>You may exercise certain rights regarding your information processed by us. In particular, you have the right to do the following: (i) you have the right to withdraw consent where you have previously given your consent to the processing of your information; (ii) you have the right to object to the processing of your information if the processing is carried out on a legal basis other than consent; (iii) you have the right to learn if information is being processed by us, obtain disclosure regarding certain aspects of the processing and obtain a copy of the information undergoing processing; (iv) you have the right to verify the accuracy of your information and ask for it to be updated or corrected; (v) you have the right, under certain circumstances, to restrict the processing of your information, in which case, we will not process your information for any purpose other than storing it; (vi) you have the right, under certain circumstances, to obtain the erasure of your Personal Information from us; (vii) you have the right to receive your information in a structured, commonly used and machine readable format and, if technically feasible, to have it transmitted to another controller without any hindrance. This provision is applicable provided that your information is processed by automated means and that the processing is based on your consent, on a contract which you are part of or on pre-contractual obligations thereof.</p><h2><strong>The right to object to processing</strong></h2><p>Where Personal Information is processed for a public interest, in the exercise of an official authority vested in us or for the purposes of the legitimate interests pursued by us, you may object to such processing by providing a ground related to your particular situation to justify the objection. You must know that, however, should your Personal Information be processed for direct marketing purposes, you can object to that processing at any time without providing any justification. To learn whether we are processing Personal Information for direct marketing purposes, you may refer to the relevant sections of this document.</p><h2><strong>How to exercise these rights</strong></h2><p>Any requests to exercise User rights can be directed to the Owner by email at <a href=\\\"mailto:support@tailwindui.com\\\"><strong>support@tailwindui.com</strong></a>. These requests can be exercised free of charge and will be addressed by the Owner as early as possible and always within one month.</p><h2><strong>Privacy of children</strong></h2><p>We do not knowingly collect any Personal Information from children under the age of 13. If you are under the age of 13, please do not submit any Personal Information through our Website. We encourage parents and legal guardians to monitor their children\'s Internet usage and to help enforce this Policy by instructing their children never to provide Personal Information through our Website without their permission. If you have reason to believe that a child under the age of 13 has provided Personal Information to us through our Website, please contact us.</p><h2><strong>Newsletters</strong></h2><p>We offer electronic newsletters which you may voluntarily subscribe to. You may choose to stop receiving our newsletter or marketing emails by following the unsubscribe instructions included in these emails or by contacting us. However, you will continue to receive essential transactional emails.</p><h2><strong>Cookies</strong></h2><p>The Website uses \\\"cookies\\\" to help personalize your online experience. A cookie is a text file that is placed on your hard disk by a web page server. Cookies cannot be used to run programs or deliver viruses to your computer. Cookies are uniquely assigned to you, and can only be read by a web server in the domain that issued the cookie to you. We may use cookies to collect, store, and track information for statistical purposes to operate our Website. You have the ability to accept or decline cookies. Most web browsers automatically accept cookies, but you can usually modify your browser setting to decline cookies if you prefer.</p><p>In addition to using cookies and related technologies as described above, we also may permit certain third-party companies to help us tailor advertising that we think may be of interest to users and to collect and use other data about user activities on the Website. These companies may deliver ads that might also place cookies and otherwise track user behavior.</p><h2><strong>Links to other websites</strong></h2><p>Our Website contains links to other websites that are not owned or controlled by us. Please be aware that we are not responsible for the privacy practices of such other websites or third parties. We encourage you to be aware when you leave our Website and to read the privacy statements of each and every website that may collect Personal Information.</p><p>In particular, as noted above, purchases made through the Website are handled by Paddle and all such transactions, including any Personal Information or non-personal information collected by Paddle, are under the control of Paddle. We encourage purchasers to read Paddle’s Privacy Policy (<a href=\\\"https://paddle.com/legal-buyers/\\\"><strong>paddle.com/legal-buyers/</strong></a>).</p><h2><strong>Information security</strong></h2><p>We secure information you provide on computer servers in a controlled, secure environment, protected from unauthorized access, use, or disclosure. We maintain reasonable administrative, technical, and physical safeguards in an effort to protect against unauthorized access, use, modification, and disclosure of Personal Information in its control and custody. However, no data transmission over the Internet or wireless network can be guaranteed. Therefore, while we strive to protect your Personal Information, you acknowledge that (i) there are security and privacy limitations of the Internet which are beyond our control; (ii) the security, integrity, and privacy of any and all information and data exchanged between you and our Website cannot be guaranteed; and (iii) any such information and data may be viewed or tampered with in transit by a third-party, despite best efforts.</p><h2><strong>Data breach</strong></h2><p>In the event we become aware that the security of the Website has been compromised or users’ Personal Information has been disclosed to unrelated third-parties as a result of external activity, including, but not limited to, security attacks or fraud, we reserve the right to take reasonably appropriate measures, including, but not limited to, investigation and reporting, as well as notification to and cooperation with law enforcement authorities. In the event of a data breach, we will make reasonable efforts to notify affected individuals if we believe that there is a reasonable risk of harm to the user as a result of the breach or if notice is otherwise required by law. When we do we will send you an email.</p><h2><strong>Legal disclosure</strong></h2><p>We will disclose any information we collect, use or receive if required or permitted by law, such as to comply with a subpoena, or similar legal process, and when we believe in good faith that disclosure is necessary to protect our rights, protect your safety or the safety of others, investigate fraud, or respond to a government request. In the event we go through a business transition, such as a merger or acquisition by another company, or sale of all or a portion of its assets, your user account and personal data will likely be among the assets transferred.</p><h2><strong>Changes and amendments</strong></h2><p>We reserve the right to modify this privacy policy relating to the Website at any time, effective upon posting of an updated version of this Policy on the Website. When we do we will revise the updated date at the bottom of this page. Continued use of the Website after any such changes shall constitute your consent to such changes.</p><h2><strong>Acceptance of this policy</strong></h2><p>You acknowledge that you have read this Policy and agree to all its terms and conditions. By using the Website you agree to be bound by this Policy. If you do not agree to abide by the terms of this Policy, you are not authorized to use or access the Website.</p>\"}', '2026-02-18 02:24:37', '2026-02-18 02:24:37'),
(2, 'Contact', 'contact', 1, '{\"email\": \"contact@mail.com\", \"phone\": \"+902930290232\", \"location\": \"8013 Alderwood St. South San Francisco, CA 94080\", \"content_text\": \"GET IN TOUCH WITH US\", \"location_map\": \"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d39206.002432144705!2d-95.4973981212445!3d29.709510002925988!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8640c16de81f3ca5%3A0xf43e0b60ae539ac9!2sGerald+D.+Hines+Waterwall+Park!5e0!3m2!1sen!2sin!4v1566305861440!5m2!1sen!2sin\", \"email_details\": \"The phrasal sequence of the is now so that many campaign and benefit\", \"phone_details\": \"The phrasal sequence of the is now so that many campaign and benefit.\", \"content_details\": \"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eius tempor incididunt ut labore et dolore magna aliqua. Ut enim adiqua minim veniam quis nostrud exercitation ullamco\"}', '2026-02-18 02:24:38', '2026-02-18 02:24:38'),
(3, 'Services', 'services', 1, '{\"contact\": {\"tag\": \"Available for freelance projects\", \"title\": \"Do you have digital project? <br> Let\'s talk.\", \"details\": \"Start working with HelpDesk that can provide everything you need to generate awareness, drive traffic, connect.\"}, \"services\": [{\"icon\": \"airplay\", \"name\": \"UX / UI Design\", \"details\": \"The phrasal sequence of the is now so that many campaign and benefit\"}, {\"icon\": \"compass\", \"name\": \"IOS App Designer\", \"details\": \"The phrasal sequence of the is now so that many campaign and benefit\"}, {\"icon\": \"camera\", \"name\": \"Photography\", \"details\": \"The phrasal sequence of the is now so that many campaign and benefit\"}, {\"icon\": \"aperture\", \"name\": \"Graphic Designer\", \"details\": \"The phrasal sequence of the is now so that many campaign and benefit\"}, {\"icon\": \"security\", \"name\": \"Web Security\", \"details\": \"The phrasal sequence of the is now so that many campaign and benefit\"}, {\"icon\": \"palette\", \"name\": \"24/7 Support\", \"details\": \"The phrasal sequence of the is now so that many campaign and benefit\"}]}', '2026-02-18 02:24:38', '2026-02-18 02:24:38'),
(4, 'Terms of Services', 'terms', 1, '{\"title\": \"Terms of Services\", \"content\": \"<h3><strong>Introduction :</strong></h3><p>It seems that only fragments of the original text remain in the Lorem Ipsum texts used today. One may speculate that over the course of time certain letters were added or deleted at various positions within the text.</p><p>&nbsp;</p><h3><strong>User Agreements :</strong></h3><p>The most well-known dummy text is the \'Lorem Ipsum\', which is said to have <strong>originated</strong> in the 16th century. Lorem Ipsum is <strong>composed</strong> in a pseudo-Latin language which more or less <strong>corresponds</strong> to \'proper\' Latin. It contains a series of real Latin words. This ancient dummy text is also <strong>incomprehensible</strong>, but it imitates the rhythm of most European languages in Latin script. The <strong>advantage</strong> of its Latin origin and the relative <strong>meaninglessness</strong> of Lorum Ipsum is that the text does not attract attention to itself or distract the viewer\'s <strong>attention</strong> from the layout.</p><p>&nbsp;</p><p>There is now an <strong>abundance</strong> of readable dummy texts. These are usually used when a text is <strong>required purely</strong> to fill a space. These alternatives to the classic Lorem Ipsum texts are often amusing and tell short, funny or <strong>nonsensical</strong> stories.</p><p>It seems that only <strong>fragments</strong> of the original text remain in the Lorem Ipsum texts used today. One may speculate that over the course of time certain letters were added or deleted at various positions within the text.</p><p>&nbsp;</p><h3><strong>Restrictions :</strong></h3><p>You are specifically restricted from all of the following :</p><ul><li>Digital Marketing Solutions for Tomorrow</li><li>Our Talented &amp; Experienced Marketing Agency</li><li>Create your own skin to match your brand</li><li>Digital Marketing Solutions for Tomorrow</li><li>Our Talented &amp; Experienced Marketing Agency</li><li>Create your own skin to match your brand</li></ul><p><br>&nbsp;</p>\"}', '2026-02-18 02:24:39', '2026-02-18 02:24:39'),
(5, 'Home', 'home', 1, '{\"sections\": [{\"image\": \"/landing/images/dashboard-helpdesk.png\", \"title\": \"Simplify your workflow with <span>HelpDesk</span>\", \"buttons\": [{\"link\": \"/login\", \"text\": \"Login HelpDesk\", \"new_tab\": \"0\"}, {\"link\": \"/ticket/open\", \"text\": \"Submit ticket\", \"new_tab\": \"0\"}], \"details\": \"Easily create, assign, manage, and resolve tickets. Just host HelpDesk on your preferred server and start using it right away.\", \"enabled\": true, \"badge_text\": \"Trusted by 10,000+ companies\", \"trust_indicators\": [\"Free 14-day trial\", \"No credit card required\", \"24/7 support\"], \"enable_ticket_section\": \"\"}, {\"title\": \"How HelpDesk Works\", \"details\": \"Here\'s how the HelpDesk process makes support simple and efficient.\\n\\n\", \"enabled\": true, \"tagline\": \"Process\", \"features\": [{\"icon\": \"ticket\", \"title\": \"Submit A ticket\", \"details\": \"Create a ticket directly from the home page or dashboard. If you don\'t have an account, you can easily open a ticket from this <a href=\'/ticket/open\'>link.\"}, {\"icon\": \"chat\", \"title\": \"Instant talk with agent\", \"details\": \"Connect instantly with an agent through the \\\"Let\'s Talk\\\" button. If your ticket requires more time, you\'ll receive updates promptly.\"}, {\"icon\": \"email\", \"title\": \"Track Progress by Email\", \"details\": \"Stay updated via email whenever your ticket status changes. You can also comment and continue discussions with the agent.\"}, {\"icon\": \"tick\", \"title\": \"Close the Ticket\", \"details\": \"Once your issue is resolved, the agent will close the ticket. You\'ll receive a notification when it\'s completed.\"}]}, {\"title\": \"Create a ticket\", \"subtitle\": \"Get help from our support team. Fill out the form below and we\'ll get back to you as soon as possible.\", \"badge_text\": \"Get Support\", \"submit_header\": \"Submit Your Request\", \"submit_subtitle\": \"We\'re here to help you resolve any issues quickly\", \"cta_submit_label\": \"Submit Ticket\", \"enable_ticket_section\": \"1\", \"login_require_create_ticket\": \"0\"}, {\"stats\": [{\"icon\": \"tick\", \"label\": \"Tickets Resolved\", \"value\": \"10,000+\"}, {\"icon\": \"users\", \"label\": \"Happy Customers\", \"value\": \"500+\"}, {\"icon\": \"clock\", \"label\": \"Avg. Response Time\", \"value\": \"< 2 hours\"}, {\"icon\": \"star\", \"label\": \"Rating\", \"value\": \"5.0★\"}], \"title\": \"Our Impact\", \"details\": \"Key metrics that showcase our success and reliability.\", \"enabled\": true, \"tagline\": \"Statistics\"}, {\"title\": \"What Our Customers Say\", \"details\": \"Read what our satisfied customers say about our helpdesk solution.\", \"enabled\": true, \"tagline\": \"Testimonials\", \"testimonials\": [{\"name\": \"John Doe\", \"rating\": 5, \"company\": \"Acme Inc.\", \"content\": \"HelpDesk streamlined our support operations.\"}, {\"name\": \"Jane Smith\", \"rating\": 5, \"company\": \"BetaCorp\", \"content\": \"Great UX and fast to deploy.\"}, {\"name\": \"Maria Johnson\", \"rating\": 5, \"company\": \"Support Manager, InnovateLab\", \"content\": \"The analytics and reporting features give us incredible insights into our support performance. Highly recommended!\"}]}]}', '2026-02-18 02:24:39', '2026-02-18 02:24:39'),
(6, 'Footer Area', 'footer', 1, '{\"text\": \"Start working with HelpDesk and get everything you need to streamline support, improve efficiency, and connect with your customers.\", \"title\": \"Footer Area\", \"copyright\": \"@ Helpdesk Developed by <a href=\'https://w3bd.com/\'>W3bd</a>.\"}', '2026-02-18 02:24:40', '2026-02-18 02:24:40');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_base`
--

CREATE TABLE `knowledge_base` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `type_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int UNSIGNED NOT NULL,
  `code` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `code`, `name`, `flag`) VALUES
(1, 'en', 'English', 'us'),
(2, 'de', 'German', 'de'),
(3, 'cn', 'Chinese', 'cn'),
(4, 'bd', 'Bengali', 'bd'),
(5, 'ur', 'Urdu', 'pk'),
(6, 'nl', 'Dutch', 'nl'),
(7, 'it', 'Italian', 'it'),
(8, 'sa', 'Arabic', 'sa'),
(9, 'tr', 'Turkish', 'tr'),
(10, 'id', 'Indonesian', 'id'),
(11, 'es', 'Spanish', 'es'),
(12, 'se', 'Swedish', 'se'),
(13, 'pt', 'Portuguese', 'pt'),
(14, 'he', 'Hebrew', 'il'),
(15, 'lt', 'Lithuanian', 'lt'),
(16, 'pl', 'Polish', 'pl'),
(17, 'fr', 'French', 'fr');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` bigint UNSIGNED DEFAULT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_folders`
--

CREATE TABLE `media_folders` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media_folders`
--

INSERT INTO `media_folders` (`id`, `name`, `parent_id`, `created_at`, `updated_at`) VALUES
(1, 'System Media Holder', NULL, '2026-02-18 02:25:08', '2026-02-18 02:25:08'),
(2, 'Images', NULL, '2026-02-18 02:25:08', '2026-02-18 02:25:08');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int UNSIGNED NOT NULL,
  `guid` int DEFAULT NULL,
  `conversation_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `contact_id` int DEFAULT NULL,
  `is_read` int NOT NULL DEFAULT '0',
  `is_internal` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_type` enum('text','image','file','system') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message_attachments`
--

CREATE TABLE `message_attachments` (
  `id` bigint UNSIGNED NOT NULL,
  `message_id` int UNSIGNED NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` bigint NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2020_01_01_000001_create_password_resets_table', 1),
(6, '2020_01_01_000002_create_failed_jobs_table', 1),
(7, '2020_01_01_000004_create_users_table', 1),
(8, '2020_01_01_000005_create_organizations_table', 1),
(9, '2020_01_01_000006_create_contacts_table', 1),
(10, '2021_12_22_110814_create_conversations_table', 1),
(11, '2021_12_22_111519_create_messages_table', 1),
(12, '2021_12_22_122111_create_participants_table', 1),
(13, '2022_05_19_114313_create_tickets_table', 1),
(14, '2022_05_19_120229_create_status_table', 1),
(15, '2022_05_19_120353_create_priorities_table', 1),
(16, '2022_05_19_120638_create_departments_table', 1),
(17, '2022_05_19_120749_create_types_table', 1),
(18, '2022_05_25_040954_create_attachments_table', 1),
(19, '2022_05_31_134932_create_countries_table', 1),
(20, '2022_06_01_051540_create_comments_table', 1),
(21, '2022_06_04_152841_create_reviews_table', 1),
(22, '2022_06_10_173021_create_cities_table', 1),
(23, '2022_06_13_042934_create_pending_emails', 1),
(24, '2022_06_15_122734_create_pending_users_table', 1),
(25, '2022_09_17_063053_create_email_templates_table', 1),
(26, '2022_09_17_185116_create_knowledge_base_table', 1),
(27, '2022_09_18_035652_create_settings_table', 1),
(28, '2022_09_18_052747_create_languages_table', 1),
(29, '2022_09_20_140009_create_posts_table', 1),
(30, '2022_09_28_072406_create_front_pages_table', 1),
(31, '2022_09_29_054634_create_faqs_table', 1),
(32, '2022_09_29_062233_create_categories_table', 1),
(33, '2022_10_05_042046_create_notes_table', 1),
(34, '2022_10_08_030455_create_jobs_table', 1),
(35, '2022_11_13_052221_create_roles_table', 1),
(36, '2022_11_20_155214_create_backup_table', 1),
(37, '2024_01_10_021030_add_fields_to_tables', 1),
(38, '2024_06_19_151134_create_ticket_fields_table', 1),
(39, '2024_06_20_064145_create_ticket_entries_table', 1),
(40, '2025_05_08_084825_add_message_id_in_reply_parent_id_to_tickets_table', 1),
(41, '2025_07_09_011019_create_media_table', 1),
(42, '2025_07_09_011020_create_media_folders_table', 1),
(43, '2025_07_09_011021_add_folder_id_to_media_table', 1),
(44, '2025_07_25_012114_create_notifications_table', 1),
(45, '2025_09_21_014639_add_dashboard_indexes_to_tickets_table', 1),
(46, '2025_09_21_100935_add_missing_chat_fields_to_messages_table', 1),
(47, '2025_09_21_200000_add_missing_fields_to_conversations_table', 1),
(48, '2025_09_21_220000_add_chat_performance_indexes', 1),
(49, '2025_09_22_045932_add_role_id_to_users_table', 1),
(50, '2025_09_22_050001_add_foreign_key_to_users_role_id', 1),
(51, '2025_09_22_062349_add_name_columns_to_users_table', 1),
(52, '2025_09_23_050335_add_enhanced_fields_to_tickets_table', 1),
(53, '2025_09_23_050353_create_ticket_activities_table', 1),
(54, '2025_09_23_061111_add_enhanced_ticket_fields_to_tickets_table', 1),
(55, '2025_09_23_065813_create_sla_policies_table', 1),
(56, '2025_09_23_065920_create_auto_assignment_rules_table', 1),
(57, '2025_09_23_091156_add_sla_policy_id_to_tickets_table', 1),
(58, '2025_09_23_115002_update_conversations_table_for_ticket_system', 1),
(59, '2025_09_23_115030_update_messages_table_for_conversation_system', 1),
(60, '2025_09_23_115050_update_participants_table_for_conversation_system', 1),
(61, '2025_09_23_115416_change_tickets_id_to_bigint', 1),
(62, '2025_09_24_052540_populate_existing_users_with_names', 1),
(63, '2025_09_24_052950_add_ticket_relationship_to_conversations_table', 1),
(64, '2025_09_24_094623_add_conversation_id_to_attachments_table', 1),
(65, '2025_09_25_014811_create_ai_ticket_classifications_table', 1),
(66, '2025_09_26_023915_add_flag_to_languages_table', 1),
(67, '2025_09_26_031945_add_locale_to_users_table', 1),
(68, '2025_09_27_065043_add_impact_urgency_levels_to_tickets_table', 1),
(69, '2025_09_27_065431_add_missing_enhanced_fields_to_tickets_table', 1),
(70, '2025_09_27_065525_add_country_id_to_pending_users_table', 1),
(71, '2025_09_27_225306_add_missing_columns_to_users_table', 1),
(72, '2025_11_20_105523_create_ticket_favorites_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `participants`
--

CREATE TABLE `participants` (
  `id` int UNSIGNED NOT NULL,
  `conversation_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `contact_id` int DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'participant',
  `joined_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pending_emails`
--

CREATE TABLE `pending_emails` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int DEFAULT NULL,
  `ticket_id` int DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pending_users`
--

CREATE TABLE `pending_users` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int DEFAULT NULL,
  `ticket_id` int DEFAULT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` bigint UNSIGNED DEFAULT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_id` int DEFAULT NULL,
  `is_active` int NOT NULL DEFAULT '1',
  `image` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `priorities`
--

CREATE TABLE `priorities` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `priorities`
--

INSERT INTO `priorities` (`id`, `name`) VALUES
(1, 'Low'),
(2, 'Medium'),
(3, 'High'),
(4, 'Critical');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int UNSIGNED NOT NULL,
  `ticket_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int DEFAULT NULL,
  `review` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `access`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin', '{\"faq\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"blog\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"chat\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"smtp\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"type\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"user\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"global\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"pusher\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"status\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"ticket\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"contact\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"category\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"customer\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"language\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"priority\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"department\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"front_page\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"organization\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"email_template\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"knowledge_base\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}}', NULL, NULL),
(2, 'Customer', 'customer', '{\"faq\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"blog\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"chat\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"smtp\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"type\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"user\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"global\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"pusher\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"status\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"ticket\": {\"read\": true, \"create\": true, \"delete\": false, \"update\": false}, \"contact\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"category\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"customer\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"language\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"priority\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"department\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"front_page\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"organization\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"email_template\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"knowledge_base\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}}', NULL, NULL),
(3, 'Agency', 'agency', '{\"faq\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"blog\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"chat\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"smtp\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"type\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"user\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"global\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"pusher\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"status\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"ticket\": {\"read\": true, \"create\": true, \"delete\": false, \"update\": true}, \"contact\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"category\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"customer\": {\"read\": true, \"create\": true, \"delete\": false, \"update\": true}, \"language\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"priority\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"department\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"front_page\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"organization\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"email_template\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"knowledge_base\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}}', NULL, NULL),
(4, 'Manager', 'manager', '{\"faq\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"blog\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"chat\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"smtp\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"type\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"user\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"global\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"pusher\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"status\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"ticket\": {\"read\": true, \"create\": true, \"delete\": false, \"update\": true}, \"contact\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"category\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"customer\": {\"read\": true, \"create\": true, \"delete\": false, \"update\": true}, \"language\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"priority\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"department\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"front_page\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"organization\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"email_template\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"knowledge_base\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}}', NULL, NULL),
(5, 'General', 'general', '{\"faq\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"blog\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"chat\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"smtp\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"type\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"user\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"global\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"pusher\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"status\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"ticket\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"contact\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"category\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"customer\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"language\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"priority\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"department\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"front_page\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"organization\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"email_template\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"knowledge_base\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}}', NULL, NULL),
(6, 'Agent', 'agent', '{\"faq\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"blog\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"chat\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"smtp\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"type\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"user\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"global\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"pusher\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"status\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"ticket\": {\"read\": true, \"create\": true, \"delete\": true, \"update\": true}, \"contact\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"category\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"customer\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"language\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"priority\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"department\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"front_page\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"organization\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"email_template\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}, \"knowledge_base\": {\"read\": false, \"create\": false, \"delete\": false, \"update\": false}}', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `slug`, `type`, `value`) VALUES
(1, 'App Name', 'app_name', 'text', 'Help Desk'),
(2, 'Email Recipient for customer ticket', 'default_recipient', 'text', '1'),
(3, 'Default Language', 'default_language', 'text', 'en'),
(4, 'Main Logo', 'main_logo', 'text', '/images/logo.png'),
(5, 'Main Logo White', 'main_logo_white', 'text', '/images/logo_white.png'),
(6, 'Main Favicon', 'main_favicon', 'text', '/favicon.png'),
(7, 'Hide_ticket_fields', 'hide_ticket_fields', 'json', '[]'),
(8, 'Required ticket fields', 'required_ticket_fields', 'json', '[]'),
(9, 'Footer Text', 'footer_text', 'text', 'Help Desk © 2022 - Powered by W3BD'),
(10, 'Enable Options', 'enable_options', 'json', '[{\"name\":\"Chat\",\"slug\":\"chat\",\"value\":false},{\"name\":\"FAQ\",\"slug\":\"faq\",\"value\":true},{\"name\":\"Knowledge Base\",\"slug\":\"kb\",\"value\":true},{\"name\":\"Blog\",\"slug\":\"blog\",\"value\":true},{\"name\":\"Contacts\",\"slug\":\"contact\",\"value\":true},{\"name\":\"Organizations\",\"slug\":\"organization\",\"value\":true},{\"name\":\"Notes\",\"slug\":\"note\",\"value\":true},{\"name\":\"Show Login on front page\",\"slug\":\"show_login\",\"value\":true},{\"name\":\"Email to tickets(piping)\",\"slug\":\"enable_piping\",\"value\":true},{\"name\":\"Service Page\",\"slug\":\"service\",\"value\":true},{\"name\":\"Show Color Picker\",\"slug\":\"color_picker\",\"value\":true},{\"name\":\"Require Login to Submit Ticket\",\"slug\":\"require_login_submit_ticket\",\"value\":false},{\"name\":\"Contact Page\",\"slug\":\"contact_page\",\"value\":true},{\"name\":\"Terms of Services\",\"slug\":\"terms_of_services\",\"value\":true},{\"name\":\"Privacy Policy\",\"slug\":\"privacy_policy\",\"value\":true},{\"name\":\"Newsletter\",\"slug\":\"newsletter\",\"value\":true},{\"name\":\"Enable Registration\",\"slug\":\"enable_registration\",\"value\":true}]'),
(11, 'Email Notifications', 'email_notifications', 'json', '[{\"name\":\"Create ticket by new customer\",\"slug\":\"create_ticket_new_customer\",\"value\":false},{\"name\":\"Create ticket from dashboard\",\"slug\":\"create_ticket_dashboard\",\"value\":false},{\"name\":\"Notification for the first comment\",\"slug\":\"first_comment\",\"value\":false},{\"name\":\"User got assigned for a task\",\"slug\":\"assigned_ticket\",\"value\":false},{\"name\":\"Status or priority changes\",\"slug\":\"status_priority\",\"value\":false},{\"name\":\"Create a new user\",\"slug\":\"user_created\",\"value\":false}]');

-- --------------------------------------------------------

--
-- Table structure for table `sla_policies`
--

CREATE TABLE `sla_policies` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `first_response_time` int DEFAULT NULL,
  `resolution_time` int DEFAULT NULL,
  `priority_conditions` json DEFAULT NULL,
  `department_conditions` json DEFAULT NULL,
  `category_conditions` json DEFAULT NULL,
  `type_conditions` json DEFAULT NULL,
  `business_hours` json DEFAULT NULL,
  `holidays` json DEFAULT NULL,
  `escalation_time` int DEFAULT NULL,
  `escalation_actions` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `name`, `slug`) VALUES
(1, 'Open', 'open'),
(2, 'Pending', 'pending'),
(3, 'In Progress', 'in_progress'),
(4, 'Resolved', 'resolved'),
(5, 'Closed', 'closed'),
(6, 'Cancelled', 'cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int UNSIGNED NOT NULL,
  `uid` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_reply_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `open` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `due` timestamp NULL DEFAULT NULL,
  `close` timestamp NULL DEFAULT NULL,
  `response` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `contact_id` int DEFAULT NULL,
  `client_type` int DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `sub_category_id` int DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `impact_level` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `urgency_level` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  `estimated_hours` decimal(8,2) DEFAULT NULL,
  `actual_hours` decimal(8,2) DEFAULT NULL,
  `sla_breach_at` timestamp NULL DEFAULT NULL,
  `resolution` text COLLATE utf8mb4_unicode_ci,
  `tags` json DEFAULT NULL,
  `source` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_ticket_id` int UNSIGNED DEFAULT NULL,
  `template_id` int UNSIGNED DEFAULT NULL,
  `last_customer_response` timestamp NULL DEFAULT NULL,
  `last_agent_response` timestamp NULL DEFAULT NULL,
  `custom_fields` json DEFAULT NULL,
  `external_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sla_policy_id` bigint UNSIGNED DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `review_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_activities`
--

CREATE TABLE `ticket_activities` (
  `id` bigint UNSIGNED NOT NULL,
  `ticket_id` int UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `activity_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_value` text COLLATE utf8mb4_unicode_ci,
  `new_value` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_entries`
--

CREATE TABLE `ticket_entries` (
  `id` bigint UNSIGNED NOT NULL,
  `ticket_id` int NOT NULL,
  `field_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_favorites`
--

CREATE TABLE `ticket_favorites` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `ticket_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_fields`
--

CREATE TABLE `ticket_fields` (
  `id` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `required` tinyint NOT NULL DEFAULT '0',
  `hint` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE `types` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `types`
--

INSERT INTO `types` (`id`, `name`) VALUES
(1, 'Bug Report'),
(2, 'Feature Request'),
(3, 'Question'),
(4, 'Service Request'),
(5, 'Incident'),
(6, 'Maintenance');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `role_id` int UNSIGNED DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Engineer',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `photo_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `title`, `name`, `first_name`, `last_name`, `email`, `phone`, `city`, `address`, `country_id`, `locale`, `photo_path`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'Engineer', '', 'prasobh', 's', 'prasobh.tech@gmail.com', NULL, NULL, NULL, NULL, 'en', NULL, '2026-02-18 02:25:09', '$2y$10$uPW4DQgntM3QkWvnVgwVTeA9154uAPYNz8wp0ZiLSc1yOyIRGCkvy', NULL, '2026-02-18 02:25:09', '2026-02-18 02:25:09');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_ticket_classifications`
--
ALTER TABLE `ai_ticket_classifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ai_ticket_classifications_ticket_id_created_at_index` (`ticket_id`,`created_at`),
  ADD KEY `ai_ticket_classifications_confidence_score_index` (`confidence_score`),
  ADD KEY `ai_ticket_classifications_ai_generated_index` (`ai_generated`),
  ADD KEY `ai_ticket_classifications_applied_index` (`applied`),
  ADD KEY `ai_ticket_classifications_priority_id_foreign` (`priority_id`),
  ADD KEY `ai_ticket_classifications_category_id_foreign` (`category_id`),
  ADD KEY `ai_ticket_classifications_department_id_foreign` (`department_id`),
  ADD KEY `ai_ticket_classifications_type_id_foreign` (`type_id`);

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachments_ticket_id_index` (`ticket_id`),
  ADD KEY `attachments_message_id_index` (`message_id`),
  ADD KEY `attachments_user_id_index` (`user_id`),
  ADD KEY `attachments_contact_id_index` (`contact_id`),
  ADD KEY `attachments_conversation_id_index` (`conversation_id`);

--
-- Indexes for table `auto_assignment_rules`
--
ALTER TABLE `auto_assignment_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auto_assignment_rules_assigned_user_id_foreign` (`assigned_user_id`),
  ADD KEY `auto_assignment_rules_assigned_department_id_foreign` (`assigned_department_id`);

--
-- Indexes for table `backup`
--
ALTER TABLE `backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_sessions`
--
ALTER TABLE `chat_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `chat_sessions_session_id_unique` (`session_id`),
  ADD KEY `chat_sessions_conversation_id_foreign` (`conversation_id`);

--
-- Indexes for table `chat_typing_indicators`
--
ALTER TABLE `chat_typing_indicators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_typing_indicators_conversation_id_is_typing_index` (`conversation_id`,`is_typing`),
  ADD KEY `chat_typing_indicators_user_id_is_typing_index` (`user_id`,`is_typing`),
  ADD KEY `chat_typing_indicators_contact_id_is_typing_index` (`contact_id`,`is_typing`),
  ADD KEY `chat_typing_indicators_updated_at_index` (`updated_at`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_ticket_id_index` (`ticket_id`),
  ADD KEY `comments_user_id_index` (`user_id`),
  ADD KEY `comments_contact_id_index` (`contact_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_organization_id_index` (`organization_id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversations_contact_id_index` (`contact_id`),
  ADD KEY `conversations_created_at_index` (`created_at`),
  ADD KEY `conversations_status_priority_index` (`status`,`priority`),
  ADD KEY `conversations_contact_id_status_index` (`contact_id`,`status`),
  ADD KEY `conversations_last_activity_index` (`last_activity`),
  ADD KEY `conversations_department_index` (`department`),
  ADD KEY `conversations_status_index` (`status`),
  ADD KEY `conversations_ticket_id_index` (`ticket_id`),
  ADD KEY `conversations_type_index` (`type`),
  ADD KEY `conversations_created_by_index` (`created_by`),
  ADD KEY `conversations_last_message_at_index` (`last_message_at`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `countries_code_index` (`code`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `front_pages`
--
ALTER TABLE `front_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `knowledge_base`
--
ALTER TABLE `knowledge_base`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`),
  ADD KEY `media_folder_id_foreign` (`folder_id`);

--
-- Indexes for table `media_folders`
--
ALTER TABLE `media_folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_folders_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_guid_index` (`guid`),
  ADD KEY `messages_conversation_id_index` (`conversation_id`),
  ADD KEY `messages_user_id_index` (`user_id`),
  ADD KEY `messages_contact_id_index` (`contact_id`),
  ADD KEY `messages_conversation_id_created_at_index` (`conversation_id`,`created_at`),
  ADD KEY `messages_is_read_user_id_index` (`is_read`,`user_id`),
  ADD KEY `messages_contact_id_created_at_index` (`contact_id`,`created_at`),
  ADD KEY `messages_message_type_index` (`message_type`),
  ADD KEY `messages_is_internal_index` (`is_internal`),
  ADD KEY `messages_read_at_index` (`read_at`);

--
-- Indexes for table `message_attachments`
--
ALTER TABLE `message_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_attachments_message_id_foreign` (`message_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notes_user_id_index` (`user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `participants`
--
ALTER TABLE `participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `participants_conversation_id_index` (`conversation_id`),
  ADD KEY `participants_user_id_index` (`user_id`),
  ADD KEY `participants_contact_id_index` (`contact_id`),
  ADD KEY `participants_user_id_conversation_id_index` (`user_id`,`conversation_id`),
  ADD KEY `participants_contact_id_conversation_id_index` (`contact_id`,`conversation_id`),
  ADD KEY `participants_role_index` (`role`),
  ADD KEY `participants_joined_at_index` (`joined_at`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pending_emails`
--
ALTER TABLE `pending_emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pending_emails_user_id_index` (`user_id`),
  ADD KEY `pending_emails_ticket_id_index` (`ticket_id`);

--
-- Indexes for table `pending_users`
--
ALTER TABLE `pending_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pending_users_email_unique` (`email`),
  ADD KEY `pending_users_user_id_index` (`user_id`),
  ADD KEY `pending_users_ticket_id_index` (`ticket_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_author_id_index` (`author_id`),
  ADD KEY `posts_type_id_index` (`type_id`);

--
-- Indexes for table `priorities`
--
ALTER TABLE `priorities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_ticket_id_index` (`ticket_id`),
  ADD KEY `reviews_user_id_index` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sla_policies`
--
ALTER TABLE `sla_policies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tickets_message_id_unique` (`message_id`),
  ADD KEY `tickets_uid_index` (`uid`),
  ADD KEY `tickets_subject_index` (`subject`),
  ADD KEY `tickets_status_id_index` (`status_id`),
  ADD KEY `tickets_user_id_index` (`user_id`),
  ADD KEY `tickets_contact_id_index` (`contact_id`),
  ADD KEY `tickets_created_by_index` (`created_by`),
  ADD KEY `tickets_priority_id_index` (`priority_id`),
  ADD KEY `tickets_department_id_index` (`department_id`),
  ADD KEY `tickets_category_id_index` (`category_id`),
  ADD KEY `tickets_sub_category_id_index` (`sub_category_id`),
  ADD KEY `tickets_assigned_to_index` (`assigned_to`),
  ADD KEY `tickets_type_id_index` (`type_id`),
  ADD KEY `idx_tickets_user_created` (`user_id`,`created_at`),
  ADD KEY `idx_tickets_assigned_created` (`assigned_to`,`created_at`),
  ADD KEY `idx_tickets_status_created` (`status_id`,`created_at`),
  ADD KEY `idx_tickets_department_created` (`department_id`,`created_at`),
  ADD KEY `idx_tickets_type_created` (`type_id`,`created_at`),
  ADD KEY `idx_tickets_created_at` (`created_at`),
  ADD KEY `idx_tickets_response` (`response`),
  ADD KEY `idx_tickets_assigned_to` (`assigned_to`),
  ADD KEY `tickets_sla_policy_id_index` (`sla_policy_id`);

--
-- Indexes for table `ticket_activities`
--
ALTER TABLE `ticket_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_activities_user_id_foreign` (`user_id`),
  ADD KEY `ticket_activities_ticket_id_created_at_index` (`ticket_id`,`created_at`),
  ADD KEY `ticket_activities_activity_type_index` (`activity_type`);

--
-- Indexes for table `ticket_entries`
--
ALTER TABLE `ticket_entries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket_favorites`
--
ALTER TABLE `ticket_favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_favorites_user_id_ticket_id_unique` (`user_id`,`ticket_id`),
  ADD KEY `ticket_favorites_user_id_index` (`user_id`),
  ADD KEY `ticket_favorites_ticket_id_index` (`ticket_id`);

--
-- Indexes for table `ticket_fields`
--
ALTER TABLE `ticket_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`),
  ADD KEY `users_country_id_index` (`country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_ticket_classifications`
--
ALTER TABLE `ai_ticket_classifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auto_assignment_rules`
--
ALTER TABLE `auto_assignment_rules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `backup`
--
ALTER TABLE `backup`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `chat_sessions`
--
ALTER TABLE `chat_sessions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_typing_indicators`
--
ALTER TABLE `chat_typing_indicators`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `front_pages`
--
ALTER TABLE `front_pages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `knowledge_base`
--
ALTER TABLE `knowledge_base`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media_folders`
--
ALTER TABLE `media_folders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `message_attachments`
--
ALTER TABLE `message_attachments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `participants`
--
ALTER TABLE `participants`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pending_emails`
--
ALTER TABLE `pending_emails`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pending_users`
--
ALTER TABLE `pending_users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `priorities`
--
ALTER TABLE `priorities`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sla_policies`
--
ALTER TABLE `sla_policies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_activities`
--
ALTER TABLE `ticket_activities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_entries`
--
ALTER TABLE `ticket_entries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_favorites`
--
ALTER TABLE `ticket_favorites`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_fields`
--
ALTER TABLE `ticket_fields`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `types`
--
ALTER TABLE `types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ai_ticket_classifications`
--
ALTER TABLE `ai_ticket_classifications`
  ADD CONSTRAINT `ai_ticket_classifications_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `ai_ticket_classifications_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `ai_ticket_classifications_priority_id_foreign` FOREIGN KEY (`priority_id`) REFERENCES `priorities` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `ai_ticket_classifications_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ai_ticket_classifications_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `attachments_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `auto_assignment_rules`
--
ALTER TABLE `auto_assignment_rules`
  ADD CONSTRAINT `auto_assignment_rules_assigned_department_id_foreign` FOREIGN KEY (`assigned_department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auto_assignment_rules_assigned_user_id_foreign` FOREIGN KEY (`assigned_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_sessions`
--
ALTER TABLE `chat_sessions`
  ADD CONSTRAINT `chat_sessions_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_typing_indicators`
--
ALTER TABLE `chat_typing_indicators`
  ADD CONSTRAINT `chat_typing_indicators_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_typing_indicators_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_typing_indicators_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `media_folder_id_foreign` FOREIGN KEY (`folder_id`) REFERENCES `media_folders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `media_folders`
--
ALTER TABLE `media_folders`
  ADD CONSTRAINT `media_folders_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `media_folders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `message_attachments`
--
ALTER TABLE `message_attachments`
  ADD CONSTRAINT `message_attachments_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_sla_policy_id_foreign` FOREIGN KEY (`sla_policy_id`) REFERENCES `sla_policies` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ticket_activities`
--
ALTER TABLE `ticket_activities`
  ADD CONSTRAINT `ticket_activities_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_activities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ticket_favorites`
--
ALTER TABLE `ticket_favorites`
  ADD CONSTRAINT `ticket_favorites_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
