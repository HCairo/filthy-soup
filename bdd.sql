-- Hôte : localhost
-- Généré le : mer. 17 avr. 2024 à 08:34
-- Version du serveur : 11.3.2-MariaDB
-- Version de PHP : 8.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `forum`
--
CREATE DATABASE IF NOT EXISTS `forum` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `forum`;

-- --------------------------------------------------------

--
-- Structure de la table `forum_mp_msg`
--

DROP TABLE IF EXISTS `forum_mp_msg`;
CREATE TABLE `forum_mp_msg` (
  `id` int(11) NOT NULL,
  `mp_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `sender_ip` varchar(40) NOT NULL,
  `date_posted` datetime NOT NULL,
  `msg` mediumtext NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `msg_read` tinyint(4) NOT NULL DEFAULT 0,
  `ratings` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forum_mp_msg`
--

INSERT INTO `forum_mp_msg` (`id`, `mp_id`, `user_id`, `sender_id`, `sender_ip`, `date_posted`, `msg`, `receiver_id`, `msg_read`, `ratings`) VALUES
(35, 25, 25, 25, '::1', '2024-04-04 23:45:47', "C'est le premier message", 26, 0, NULL),
(36, 25, 26, 25, '::1', '2024-04-04 23:45:47', "C'est le premier message", 26, 0, NULL),
(37, 26, 25, 25, '::1', '2024-04-04 23:46:10', "C'est le second message", 26, 0, NULL),
(38, 26, 26, 25, '::1', '2024-04-04 23:46:10', "C'est le second message", 26, 0, NULL),
(39, 27, 25, 25, '::1', '2024-04-04 23:47:15', 'Ceci est le message n°3', 26, 0, NULL),
(40, 27, 26, 25, '::1', '2024-04-04 23:47:15', 'Ceci est le message n°3', 26, 0, NULL),
(41, 28, 25, 25, '::1', '2024-04-05 00:32:14', "C'est le numéro 4", 26, 0, NULL),
(42, 28, 26, 25, '::1', '2024-04-05 00:32:14', "C'est le numéro 4", 26, 0, NULL),
(43, 29, 25, 25, '::1', '2024-04-05 09:22:14', 'Test 5', 26, 0, NULL),
(44, 29, 26, 25, '::1', '2024-04-05 09:22:14', 'Test 5', 26, 0, NULL),
(49, 32, 28, 28, '127.0.0.1', '2024-04-05 11:50:03', 'Nul', 25, 0, NULL),
(50, 32, 25, 28, '127.0.0.1', '2024-04-05 11:50:03', 'Nul', 25, 0, NULL),
(51, 33, 28, 28, '127.0.0.1', '2024-04-05 12:04:08', 'Bozo', 26, 0, NULL),
(52, 33, 26, 28, '127.0.0.1', '2024-04-05 12:04:08', 'Bozo', 26, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `forum_mp_subject`
--

DROP TABLE IF EXISTS `forum_mp_subject`;
CREATE TABLE `forum_mp_subject` (
  `id` int(11) NOT NULL,
  `msg` mediumtext DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `owner_ip` varchar(40) DEFAULT NULL,
  `date_sent` datetime DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forum_mp_subject`
--

INSERT INTO `forum_mp_subject` (`id`, `msg`, `owner_id`, `owner_ip`, `date_sent`, `date_updated`) VALUES
(25, 'Message n°1', 25, '::1', '2024-04-04 23:45:47', NULL),
(26, 'Message n°2', 25, '::1', '2024-04-04 23:46:10', NULL),
(27, 'Message. n°3', 25, '::1', '2024-04-04 23:47:15', NULL),
(28, 'Message n°4', 25, '::1', '2024-04-05 00:32:14', NULL),
(29, 'Message n°5', 25, '::1', '2024-04-05 09:22:14', NULL),
(30, '', 28, '127.0.0.1', '2024-04-05 10:40:03', NULL),
(31, '', 28, '127.0.0.1', '2024-04-05 10:40:11', NULL),
(32, 'PHP', 28, '127.0.0.1', '2024-04-05 11:50:03', NULL),
(33, 'DEAD', 28, '127.0.0.1', '2024-04-05 12:04:08', NULL),
(34, '', 28, '127.0.0.1', '2024-04-05 12:08:46', NULL),
(35, '', 28, '127.0.0.1', '2024-04-08 09:33:26', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `forum_polls`
--

DROP TABLE IF EXISTS `forum_polls`;
CREATE TABLE `forum_polls` (
  `id` int(11) NOT NULL,
  `poll_question` varchar(150) NOT NULL,
  `poll_start` datetime NOT NULL,
  `poll_end` datetime NOT NULL,
  `active` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_polls_options`
--

DROP TABLE IF EXISTS `forum_polls_options`;
CREATE TABLE `forum_polls_options` (
  `id` int(11) NOT NULL,
  `poll_id` int(11) NOT NULL,
  `poll_option` varchar(200) NOT NULL,
  `poll_votes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_post`
--

DROP TABLE IF EXISTS `forum_post`;
CREATE TABLE `forum_post` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `msg` mediumtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_ip` varchar(40) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `edited_by_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `post_hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forum_post`
--

INSERT INTO `forum_post` (`id`, `topic_id`, `msg`, `user_id`, `user_ip`, `created_at`, `updated_at`, `edited_by_id`, `rating`, `post_hide`) VALUES
(1, 1, 'TRalala pouet pouet', 25, '::1', '2024-03-27 13:03:59', '2024-03-27 13:03:59', 0, NULL, 0),
(2, 1, 'Tagada tsoin tsoin', 25, '::1', '2024-04-04 13:03:59', '2024-04-04 13:03:59', 0, NULL, 0),
(3, 2, 'TRalala pouet pouet', 25, '::1', '2024-03-27 13:03:59', '2024-03-27 13:03:59', 0, NULL, 0),
(4, 2, 'Tagada tsoin tsoin', 25, '::1', '2024-04-04 13:03:59', '2024-04-04 13:03:59', 0, NULL, 0),
(5, 4, 'Bof', 28, '127.0.0.1', '2024-04-08 11:41:33', '2024-04-15 09:32:47', 0, NULL, 0),
(6, 5, "C'est cool", 28, '127.0.0.1', '2024-04-08 12:46:24', '2024-04-15 09:32:56', 0, NULL, 0),
(7, 6, 'Loser', 28, '127.0.0.1', '2024-04-08 12:46:54', '2024-04-15 09:33:11', 0, NULL, 0),
(8, 23, 'C cher', 28, '127.0.0.1', '2024-04-08 12:48:41', '2024-04-15 09:33:05', 0, NULL, 0),
(9, 24, 'Truc de fou', 28, '127.0.0.1', '2024-04-15 10:33:11', NULL, 0, NULL, 0),
(10, 6, "Ouais c'est vrai", 28, '127.0.0.1', '2024-04-16 11:02:03', '2024-04-16 11:02:27', 0, NULL, 0),
(11, 36, 'BLUE', 28, '127.0.0.1', '2024-04-16 12:02:30', NULL, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `forum_theme`
--

DROP TABLE IF EXISTS `forum_theme`;
CREATE TABLE `forum_theme` (
  `id` int(11) NOT NULL,
  `nom` varchar(120) NOT NULL,
  `theme_position` tinyint(4) NOT NULL DEFAULT 0,
  `theme_img_url` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forum_theme`
--

INSERT INTO `forum_theme` (`id`, `nom`, `theme_position`, `theme_img_url`) VALUES
(1, 'Martial Art', 0, 0),
(2, 'Football', 0, 0),
(3, 'Vehicle', 0, 0),
(4, 'Dice', 0, 0),
(5, 'E-Sport', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `forum_topic`
--

DROP TABLE IF EXISTS `forum_topic`;
CREATE TABLE `forum_topic` (
  `id` int(11) NOT NULL,
  `title` varchar(180) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `user_ip` varchar(40) NOT NULL,
  `theme_id` int(11) NOT NULL DEFAULT 0,
  `poll_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `first_post_id` int(11) NOT NULL DEFAULT 0,
  `first_post_date` datetime NOT NULL DEFAULT current_timestamp(),
  `last_post_id` int(11) NOT NULL DEFAULT 0,
  `last_post_date` datetime DEFAULT NULL,
  `num_views` int(11) NOT NULL DEFAULT 0,
  `num_replies` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forum_topic`
--

INSERT INTO `forum_topic` (`id`, `title`, `user_id`, `user_ip`, `theme_id`, `poll_id`, `created_at`, `updated_at`, `first_post_id`, `first_post_date`, `last_post_id`, `last_post_date`, `num_views`, `num_replies`) VALUES
(1, "Aikido, c'est beau", 25, '::1', 1, NULL, '2024-03-27 14:03:59', NULL, 1, '2024-03-27 13:03:59', 0, '2024-03-27 13:03:59', 0, 0),
(2, 'Aikido, Les hommes qui portent des jupettes', 25, '::1', 1, NULL, '2024-04-04 14:03:59', NULL, 1, '2024-04-04 13:03:59', 0, '2024-04-04 13:03:59', 0, 0),
(3, 'Pessi, fraude argentine.', 28, '::1', 2, NULL, '2024-04-08 10:34:01', NULL, 0, '2024-04-08 10:34:01', 0, NULL, 0, 0),
(5, 'Les des pipes', 28, '127.0.0.1', 4, NULL, '2024-04-08 14:46:24', NULL, 0, '2024-04-08 14:46:24', 0, NULL, 0, 1),
(23, 'Lamborghini', 28, '127.0.0.1', 3, NULL, '2024-04-08 14:48:41', NULL, 0, '2024-04-08 14:48:41', 0, NULL, 0, 1),
(24, 'PSG, CL CURSE', 28, '127.0.0.1', 2, NULL, '2024-04-15 10:30:32', NULL, 0, '2024-04-15 10:30:32', 0, NULL, 0, 0),
(26, 'Haaland, finito ?', 28, '127.0.0.1', 2, NULL, '2024-04-15 11:33:15', NULL, 0, '2024-04-15 11:33:15', 0, NULL, 0, 0),
(31, 'Muay Thai, hardcore', 28, '127.0.0.1', 1, NULL, '2024-04-15 11:52:16', NULL, 0, '2024-04-15 11:52:16', 0, NULL, 0, 0),
(32, 'McGregor revient sur le ring', 28, '127.0.0.1', 1, NULL, '2024-04-15 11:53:45', NULL, 0, '2024-04-15 11:53:45', 0, NULL, 0, 0),
(33, 'Mbappe, frate', 28, '127.0.0.1', 2, NULL, '2024-04-15 12:02:02', NULL, 0, '2024-04-15 12:02:02', 0, NULL, 0, 0),
(34, 'Ford, incroyable histoire', 28, '127.0.0.1', 3, NULL, '2024-04-15 12:04:38', NULL, 0, '2024-04-15 12:04:38', 0, NULL, 0, 0),
(35, 'Lacazette, la gazelle', 28, '127.0.0.1', 2, NULL, '2024-04-15 12:05:48', NULL, 0, '2024-04-15 12:05:48', 0, NULL, 0, 0),
(36, 'KarmineCorp, sur le toit du monde', 28, '127.0.0.1', 5, NULL, '2024-04-16 12:02:09', NULL, 0, '2024-04-16 12:02:09', 0, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `forum_users_ban`
--

DROP TABLE IF EXISTS `forum_users_ban`;
CREATE TABLE `forum_users_ban` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_ip` varchar(40) NOT NULL,
  `user_email` varchar(40) NOT NULL,
  `msg` mediumtext NOT NULL,
  `ban_date` datetime NOT NULL,
  `ban_expire` datetime DEFAULT NULL,
  `ban_moderator` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `gender_id` int(11) DEFAULT NULL,
  `level_id` tinyint(4) NOT NULL DEFAULT 0,
  `username` varchar(70) NOT NULL,
  `avatar_link` mediumtext DEFAULT NULL,
  `email` varchar(120) NOT NULL,
  `email_show` tinyint(4) NOT NULL DEFAULT 0,
  `email_blocked` tinyint(4) NOT NULL DEFAULT 0,
  `password` varchar(100) NOT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `address` varchar(180) DEFAULT NULL,
  `country` varchar(80) DEFAULT NULL,
  `city` varchar(80) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `registration_date` datetime NOT NULL DEFAULT current_timestamp(),
  `registration_ip` varchar(40) NOT NULL,
  `last_update_date` datetime DEFAULT NULL,
  `number_posts` int(11) DEFAULT NULL,
  `number_pm` int(11) DEFAULT NULL,
  `blocked` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_blocked`
--

DROP TABLE IF EXISTS `user_blocked`;
CREATE TABLE `user_blocked` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `requester_id` int(11) NOT NULL,
  `blocked_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_gender`
--

DROP TABLE IF EXISTS `user_gender`;
CREATE TABLE `user_gender` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_gender`
--

INSERT INTO `user_gender` (`id`, `name`) VALUES
(2, 'Female'),
(1, 'Male'),
(3, 'Non-Binary'),
(6, 'Not Specified'),
(5, 'Queer'),
(4, 'Transgender');

-- --------------------------------------------------------

--
-- Structure de la table `user_level`
--

DROP TABLE IF EXISTS `user_level`;
CREATE TABLE `user_level` (
  `id` int(11) NOT NULL,
  `level` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_level`
--

INSERT INTO `user_level` (`id`, `level`) VALUES
(1, 'Guest'),
(2, 'Member'),
(3, 'Moderator'),
(4, 'Administrator');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `forum_mp_msg`
--
ALTER TABLE `forum_mp_msg`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `forum_mp_subject`
--
ALTER TABLE `forum_mp_subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ExchangeSenderId_ParticipantUserId` (`owner_id`);

--
-- Index pour la table `forum_polls`
--
ALTER TABLE `forum_polls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `forum_polls_options`
--
ALTER TABLE `forum_polls_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `poll_id` (`poll_id`);

--
-- Index pour la table `forum_post`
--
ALTER TABLE `forum_post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_PostUserId_UserID` (`user_id`),
  ADD KEY `FK_PostTopicId_TopicID` (`topic_id`);

--
-- Index pour la table `forum_theme`
--
ALTER TABLE `forum_theme`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`nom`);

--
-- Index pour la table `forum_topic`
--
ALTER TABLE `forum_topic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQ_Title_IdTheme` (`title`,`theme_id`),
  ADD KEY `FK_TopicUserId_UserID` (`user_id`),
  ADD KEY `FK_TopicThemeId_ThemeID` (`theme_id`);

--
-- Index pour la table `forum_users_ban`
--
ALTER TABLE `forum_users_ban`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `FK_UsergenderId_genderId` (`gender_id`);

--
-- Index pour la table `user_blocked`
--
ALTER TABLE `user_blocked`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_BeRequesterId_ParticipantUserId` (`requester_id`),
  ADD KEY `FK_BeBlockedId_ParticipantUserId` (`blocked_id`);

--
-- Index pour la table `user_gender`
--
ALTER TABLE `user_gender`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `user_level`
--
ALTER TABLE `user_level`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `forum_mp_msg`
--
ALTER TABLE `forum_mp_msg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT pour la table `forum_mp_subject`
--
ALTER TABLE `forum_mp_subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT pour la table `forum_polls`
--
ALTER TABLE `forum_polls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `forum_polls_options`
--
ALTER TABLE `forum_polls_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `forum_post`
--
ALTER TABLE `forum_post`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `forum_theme`
--
ALTER TABLE `forum_theme`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `forum_topic`
--
ALTER TABLE `forum_topic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT pour la table `forum_users_ban`
--
ALTER TABLE `forum_users_ban`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `user_blocked`
--
ALTER TABLE `user_blocked`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_gender`
--
ALTER TABLE `user_gender`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `user_level`
--
ALTER TABLE `user_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `forum_polls_options`
--
ALTER TABLE `forum_polls_options`
  ADD CONSTRAINT `forum_polls_options_ibfk_1` FOREIGN KEY (`poll_id`) REFERENCES `forum_polls` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `forum_post`
--
ALTER TABLE `forum_post`
  ADD CONSTRAINT `FK_PostTopicId_TopicID` FOREIGN KEY (`topic_id`) REFERENCES `forum_topic` (`id`),
  ADD CONSTRAINT `FK_PostUserId_UserID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `forum_topic`
--
ALTER TABLE `forum_topic`
  ADD CONSTRAINT `FK_TopicThemeId_ThemeID` FOREIGN KEY (`theme_id`) REFERENCES `forum_theme` (`id`),
  ADD CONSTRAINT `FK_TopicUserId_UserID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `forum_users_ban`
--
ALTER TABLE `forum_users_ban`
  ADD CONSTRAINT `forum_users_ban_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_UsergenderId_genderId` FOREIGN KEY (`gender_id`) REFERENCES `user_gender` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
