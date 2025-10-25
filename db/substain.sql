-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2025 at 10:47 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `substain`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add contributor', 1, 'add_contributor'),
(2, 'Can change contributor', 1, 'change_contributor'),
(3, 'Can delete contributor', 1, 'delete_contributor'),
(4, 'Can view contributor', 1, 'view_contributor'),
(5, 'Can add project', 2, 'add_project'),
(6, 'Can change project', 2, 'change_project'),
(7, 'Can delete project', 2, 'delete_project'),
(8, 'Can view project', 2, 'view_project'),
(9, 'Can add task', 3, 'add_task'),
(10, 'Can change task', 3, 'change_task'),
(11, 'Can delete task', 3, 'delete_task'),
(12, 'Can view task', 3, 'view_task'),
(13, 'Can add log entry', 4, 'add_logentry'),
(14, 'Can change log entry', 4, 'change_logentry'),
(15, 'Can delete log entry', 4, 'delete_logentry'),
(16, 'Can view log entry', 4, 'view_logentry'),
(17, 'Can add permission', 5, 'add_permission'),
(18, 'Can change permission', 5, 'change_permission'),
(19, 'Can delete permission', 5, 'delete_permission'),
(20, 'Can view permission', 5, 'view_permission'),
(21, 'Can add group', 6, 'add_group'),
(22, 'Can change group', 6, 'change_group'),
(23, 'Can delete group', 6, 'delete_group'),
(24, 'Can view group', 6, 'view_group'),
(25, 'Can add user', 7, 'add_user'),
(26, 'Can change user', 7, 'change_user'),
(27, 'Can delete user', 7, 'delete_user'),
(28, 'Can view user', 7, 'view_user'),
(29, 'Can add content type', 8, 'add_contenttype'),
(30, 'Can change content type', 8, 'change_contenttype'),
(31, 'Can delete content type', 8, 'delete_contenttype'),
(32, 'Can view content type', 8, 'view_contenttype'),
(33, 'Can add session', 9, 'add_session'),
(34, 'Can change session', 9, 'change_session'),
(35, 'Can delete session', 9, 'delete_session'),
(36, 'Can view session', 9, 'view_session');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(4, 'admin', 'logentry'),
(6, 'auth', 'group'),
(5, 'auth', 'permission'),
(7, 'auth', 'user'),
(8, 'contenttypes', 'contenttype'),
(9, 'sessions', 'session'),
(1, 'tracker', 'contributor'),
(2, 'tracker', 'project'),
(3, 'tracker', 'task');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-10-23 04:50:52.256028'),
(2, 'auth', '0001_initial', '2025-10-23 04:50:52.428462'),
(3, 'admin', '0001_initial', '2025-10-23 04:50:52.495839'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-10-23 04:50:52.504143'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-10-23 04:50:52.514634'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-10-23 04:50:52.564221'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-10-23 04:50:52.606607'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-10-23 04:50:52.627236'),
(9, 'auth', '0004_alter_user_username_opts', '2025-10-23 04:50:52.643131'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-10-23 04:50:52.669933'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-10-23 04:50:52.677186'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-10-23 04:50:52.685486'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-10-23 04:50:52.701179'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-10-23 04:50:52.717415'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-10-23 04:50:52.735331'),
(16, 'auth', '0011_update_proxy_permissions', '2025-10-23 04:50:52.746492'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-10-23 04:50:52.760016'),
(18, 'sessions', '0001_initial', '2025-10-23 04:50:52.781202'),
(19, 'tracker', '0001_initial', '2025-10-23 04:50:52.892244');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_contributor`
--

CREATE TABLE `tracker_contributor` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`skills`)),
  `joined_on` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tracker_contributor`
--

INSERT INTO `tracker_contributor` (`id`, `name`, `email`, `skills`, `joined_on`) VALUES
(1, 'Aisha Thomas', 'aisha.thomas@example.com', '[\"Python\", \"Django\", \"APIs\"]', '2025-10-23'),
(2, 'Rahul Nair', 'rahul.nair@example.com', '[\"Frontend\", \"React\", \"UI/UX\"]', '2025-10-23'),
(3, 'Sneha Kapoor', 'sneha.kapoor@example.com', '[\"Database\", \"SQL\", \"MongoDB\"]', '2025-10-23'),
(4, 'Arjun Mehta', 'arjun.mehta@example.com', '[\"DevOps\", \"Docker\", \"AWS\"]', '2025-10-23'),
(5, 'Priya Ramesh', 'priya.ramesh@example.com', '[\"Testing\", \"Automation\", \"Postman\"]', '2025-10-23'),
(6, 'Neha Verma', 'neha.verma@example.com', '[\"Sustainability\", \"Waste Management\", \"Recycling\"]', '2025-10-23'),
(7, 'Kiran Das', 'kiran.das@example.com', '[\"Water Conservation\", \"Community Outreach\"]', '2025-10-23'),
(8, 'Maria D’Souza', 'maria.dsouza@example.com', '[\"Data Analysis\", \"GIS Mapping\", \"Python\"]', '2025-10-23'),
(9, 'Vivek Raj', 'vivek.raj@example.com', '[\"Renewable Energy\", \"Solar Panel Design\"]', '2025-10-23'),
(10, 'Fatima Hussain', 'fatima.hussain@example.com', '[\"Public Awareness\", \"Education\", \"Documentation\"]', '2025-10-23'),
(11, 'Aditya Menon', 'aditya.menon@example.com', '[\"Renewable Energy\", \"Project Management\", \"Team Leadership\"]', '2025-10-23'),
(12, 'Lakshmi Nambiar', 'lakshmi.nambiar@example.com', '[\"Community Engagement\", \"Content Writing\", \"Public Relations\"]', '2025-10-23');

-- --------------------------------------------------------

--
-- Table structure for table `tracker_project`
--

CREATE TABLE `tracker_project` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `location` varchar(200) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tracker_project`
--

INSERT INTO `tracker_project` (`id`, `name`, `description`, `location`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Clean Shores Initiative', 'Beach cleanup and waste segregation drive along coastal areas.', 'Kochi', 'active', '2025-10-23 04:52:01.451369', '2025-10-23 04:52:01.451369'),
(2, 'Green Campus Project', 'Planting trees and installing solar lights in educational institutions.', 'Thiruvananthapuram', 'active', '2025-10-23 04:52:36.727148', '2025-10-23 04:52:36.727148'),
(3, 'Save Water Challenge', 'Awareness campaign and installation of rainwater harvesting systems.', 'Kannur', 'on_hold', '2025-10-23 04:53:00.595691', '2025-10-23 04:53:00.595691'),
(4, 'Solar Village Program', 'Solar energy adoption in rural areas to reduce carbon footprint.', 'Palakkad', 'completed', '2025-10-23 04:53:20.163538', '2025-10-23 04:53:20.163538'),
(5, 'E-Waste Collection Drive', 'Collection and recycling of electronic waste across districts.', 'Calicut', 'active', '2025-10-23 04:53:39.638938', '2025-10-23 04:53:39.639698'),
(6, 'Plastic-Free Market', 'Encouraging vendors to replace plastic bags with eco-friendly alternatives.', 'Alappuzha', 'completed', '2025-10-23 04:53:58.401126', '2025-10-23 04:53:58.401126'),
(7, 'Community Composting Mission', 'Promoting organic waste composting at community level.', 'Thrissur', 'active', '2025-10-23 04:54:13.247051', '2025-10-23 04:54:13.247051'),
(8, 'Smart Waste Segregation', 'Implementation of IoT-based waste sorting bins in the city.', 'Ernakulam', 'active', '2025-10-23 04:54:36.946945', '2025-10-23 04:54:36.946945'),
(9, 'Clean River Campaign', 'River cleaning and biodiversity restoration initiative.', 'Kottayam', 'on_hold', '2025-10-23 04:54:57.155713', '2025-10-23 04:54:57.155713'),
(10, 'Green Tech Hackathon', 'Hackathon to build digital tools for sustainability tracking.', 'Kollam', 'completed', '2025-10-23 04:55:18.837088', '2025-10-23 04:55:18.837088'),
(11, 'Clean Waste', 'Clean waste from household', 'Kottayam', 'active', '2025-10-23 04:56:15.864636', '2025-10-23 04:56:15.864636');

-- --------------------------------------------------------

--
-- Table structure for table `tracker_task`
--

CREATE TABLE `tracker_task` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `due_date` date DEFAULT NULL,
  `is_completed` tinyint(1) NOT NULL,
  `is_overdue` tinyint(1) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tracker_task`
--

INSERT INTO `tracker_task` (`id`, `title`, `description`, `due_date`, `is_completed`, `is_overdue`, `project_id`) VALUES
(1, 'Beach Cleanup Drive', 'Organize a volunteer cleanup event and collect plastic waste along the shoreline.', '2025-10-23', 0, 1, 1),
(2, 'Campus Tree Plantation', 'Plant 100 native trees in the campus botanical area.', '2025-10-24', 0, 0, 2),
(3, 'Solar Panel Installation', 'Mount and test solar panels at the community center.', '2025-10-23', 0, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `tracker_task_contributors`
--

CREATE TABLE `tracker_task_contributors` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `contributor_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tracker_task_contributors`
--

INSERT INTO `tracker_task_contributors` (`id`, `task_id`, `contributor_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `tracker_contributor`
--
ALTER TABLE `tracker_contributor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `tracker_project`
--
ALTER TABLE `tracker_project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tracker_task`
--
ALTER TABLE `tracker_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tracker_task_project_id_e332341b_fk_tracker_project_id` (`project_id`);

--
-- Indexes for table `tracker_task_contributors`
--
ALTER TABLE `tracker_task_contributors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tracker_task_contributors_task_id_contributor_id_384299d5_uniq` (`task_id`,`contributor_id`),
  ADD KEY `tracker_task_contrib_contributor_id_f2a9727a_fk_tracker_c` (`contributor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tracker_contributor`
--
ALTER TABLE `tracker_contributor`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tracker_project`
--
ALTER TABLE `tracker_project`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tracker_task`
--
ALTER TABLE `tracker_task`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tracker_task_contributors`
--
ALTER TABLE `tracker_task_contributors`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `tracker_task`
--
ALTER TABLE `tracker_task`
  ADD CONSTRAINT `tracker_task_project_id_e332341b_fk_tracker_project_id` FOREIGN KEY (`project_id`) REFERENCES `tracker_project` (`id`);

--
-- Constraints for table `tracker_task_contributors`
--
ALTER TABLE `tracker_task_contributors`
  ADD CONSTRAINT `tracker_task_contrib_contributor_id_f2a9727a_fk_tracker_c` FOREIGN KEY (`contributor_id`) REFERENCES `tracker_contributor` (`id`),
  ADD CONSTRAINT `tracker_task_contributors_task_id_5ff80ad5_fk_tracker_task_id` FOREIGN KEY (`task_id`) REFERENCES `tracker_task` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
