/*
Navicat MySQL Data Transfer

Source Server         : MyTest
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : football

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2019-12-25 23:14:09
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO `auth_permission` VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('24', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('25', 'Can add history', '7', 'add_history');
INSERT INTO `auth_permission` VALUES ('26', 'Can change history', '7', 'change_history');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete history', '7', 'delete_history');
INSERT INTO `auth_permission` VALUES ('28', 'Can view history', '7', 'view_history');
INSERT INTO `auth_permission` VALUES ('29', 'Can add european', '8', 'add_european');
INSERT INTO `auth_permission` VALUES ('30', 'Can change european', '8', 'change_european');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete european', '8', 'delete_european');
INSERT INTO `auth_permission` VALUES ('32', 'Can view european', '8', 'view_european');
INSERT INTO `auth_permission` VALUES ('33', 'Can add big or small', '9', 'add_bigorsmall');
INSERT INTO `auth_permission` VALUES ('34', 'Can change big or small', '9', 'change_bigorsmall');
INSERT INTO `auth_permission` VALUES ('35', 'Can delete big or small', '9', 'delete_bigorsmall');
INSERT INTO `auth_permission` VALUES ('36', 'Can view big or small', '9', 'view_bigorsmall');
INSERT INTO `auth_permission` VALUES ('37', 'Can add asia', '10', 'add_asia');
INSERT INTO `auth_permission` VALUES ('38', 'Can change asia', '10', 'change_asia');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete asia', '10', 'delete_asia');
INSERT INTO `auth_permission` VALUES ('40', 'Can view asia', '10', 'view_asia');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$150000$yk0uGBlaQUWB$lP3AjwcjQ6cFrl4DMV/UIP/u3WjyfpAX1ThoWRZ8v+4=', null, '1', 'linhaichao', '', '', '604587316@qq.com', '1', '1', '2019-12-24 13:08:40.130128');

-- ----------------------------
-- Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('10', 'Historical', 'asia');
INSERT INTO `django_content_type` VALUES ('9', 'Historical', 'bigorsmall');
INSERT INTO `django_content_type` VALUES ('8', 'Historical', 'european');
INSERT INTO `django_content_type` VALUES ('7', 'Historical', 'history');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'Historical', '0001_initial', '2019-12-24 13:06:42.078296');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0001_initial', '2019-12-24 13:06:44.302916');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2019-12-24 13:06:45.845861');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0001_initial', '2019-12-24 13:06:53.900302');
INSERT INTO `django_migrations` VALUES ('5', 'admin', '0002_logentry_remove_auto_add', '2019-12-24 13:06:55.469528');
INSERT INTO `django_migrations` VALUES ('6', 'admin', '0003_logentry_add_action_flag_choices', '2019-12-24 13:06:55.498529');
INSERT INTO `django_migrations` VALUES ('7', 'contenttypes', '0002_remove_content_type_name', '2019-12-24 13:06:56.559337');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0002_alter_permission_name_max_length', '2019-12-24 13:06:57.324654');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0003_alter_user_email_max_length', '2019-12-24 13:06:58.291165');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0004_alter_user_username_opts', '2019-12-24 13:06:58.388365');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0005_alter_user_last_login_null', '2019-12-24 13:06:59.370262');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0006_require_contenttypes_0002', '2019-12-24 13:06:59.423900');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0007_alter_validators_add_error_messages', '2019-12-24 13:06:59.453905');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0008_alter_user_username_max_length', '2019-12-24 13:07:00.267800');
INSERT INTO `django_migrations` VALUES ('15', 'auth', '0009_alter_user_last_name_max_length', '2019-12-24 13:07:01.124676');
INSERT INTO `django_migrations` VALUES ('16', 'auth', '0010_alter_group_name_max_length', '2019-12-24 13:07:02.146124');
INSERT INTO `django_migrations` VALUES ('17', 'auth', '0011_update_proxy_permissions', '2019-12-24 13:07:02.205521');
INSERT INTO `django_migrations` VALUES ('18', 'sessions', '0001_initial', '2019-12-24 13:07:02.495139');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for `historical_asia`
-- ----------------------------
DROP TABLE IF EXISTS `historical_asia`;
CREATE TABLE `historical_asia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` varchar(8) NOT NULL,
  `immediateUpperStage` double NOT NULL,
  `immediateLowerStage` double NOT NULL,
  `immediateOpening` varchar(20) NOT NULL,
  `startUpperStage` double NOT NULL,
  `startLowerStage` double NOT NULL,
  `startOpening` varchar(20) NOT NULL,
  `changedTime` varchar(12) NOT NULL,
  `startTime` varchar(12) NOT NULL,
  `subMatchId_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Historical_asia_subMatchId_id_54ded90f_fk_Historica` (`subMatchId_id`),
  CONSTRAINT `Historical_asia_subMatchId_id_54ded90f_fk_Historica` FOREIGN KEY (`subMatchId_id`) REFERENCES `historical_history` (`matchId`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of historical_asia
-- ----------------------------
INSERT INTO `historical_asia` VALUES ('1', 'Bet365', '1.069', '0.83', '受平手/半球', '0.86', '1.04', '受半球', '12-21 11:36', '12-14 17:51', '869884');
INSERT INTO `historical_asia` VALUES ('2', '澳门', '0.7', '1.1', '受半球', '0.92', '0.88', '受平手/半球', '12-21 11:31', '12-16 21:07', '869884');
INSERT INTO `historical_asia` VALUES ('3', '皇冠', '0.81', '1.09', '受半球', '0.88', '1', '受半球', '12-21 11:41', '12-14 17:52', '869884');
INSERT INTO `historical_asia` VALUES ('4', '威廉希尔', '0.8', '0.91', '受半球', '0.8', '0.91', '受半球', '12-21 11:40', '12-13 20:00', '869884');
INSERT INTO `historical_asia` VALUES ('5', 'Bet365', '0.909', '0.99', '半球', '1.06', '0.84', '半球', '12-21 13:59', '12-14 21:44', '869882');
INSERT INTO `historical_asia` VALUES ('6', '澳门', '0.84', '0.96', '半球', '0.92', '0.88', '半球', '12-21 13:55', '12-16 21:07', '869882');
INSERT INTO `historical_asia` VALUES ('7', '皇冠', '0.91', '0.98', '半球', '1.06', '0.82', '半球', '12-21 13:59', '12-14 21:44', '869882');
INSERT INTO `historical_asia` VALUES ('8', '威廉希尔', '0.85', '0.85', '半球', '0.91', '0.8', '半球', '12-17 21:02', '12-13 20:00', '869882');
INSERT INTO `historical_asia` VALUES ('9', 'Bet365', '0.909', '0.99', '半球/一球', '0.96', '0.94', '半球/一球', '12-21 16:29', '12-14 20:28', '869886');
INSERT INTO `historical_asia` VALUES ('10', '澳门', '0.84', '0.96', '半球/一球', '0.84', '0.96', '半球/一球', '12-21 16:25', '12-16 21:08', '869886');
INSERT INTO `historical_asia` VALUES ('11', '皇冠', '0.91', '0.98', '半球/一球', '0.96', '0.92', '半球/一球', '12-21 16:28', '12-13 21:14', '869886');
INSERT INTO `historical_asia` VALUES ('12', '威廉希尔', '0.83', '0.93', '半球/一球', '0.96', '0.86', '半球/一球', '12-21 16:26', '12-13 20:26', '869886');
INSERT INTO `historical_asia` VALUES ('13', 'Bet365', '0.875', '0.975', '平手', '0.825', '1.023', '平手/半球', '12-21 19:49', '12-11 23:43', '825903');
INSERT INTO `historical_asia` VALUES ('14', '澳门', '0.88', '0.92', '平手', '1.03', '0.77', '平手/半球', '12-21 19:55', '12-17 22:31', '825903');
INSERT INTO `historical_asia` VALUES ('15', '皇冠', '0.9', '0.99', '平手', '0.9', '0.98', '平手/半球', '12-21 19:56', '12-12 02:02', '825903');
INSERT INTO `historical_asia` VALUES ('16', '威廉希尔', '0.84', '0.92', '平手', '0.81', '0.96', '平手/半球', '12-21 19:53', '12-12 01:09', '825903');
INSERT INTO `historical_asia` VALUES ('17', 'Bet365', '0.899', '0.95', '受半球/一球', '1.023', '0.825', '受平手/半球', '12-21 19:58', '12-11 23:43', '825907');
INSERT INTO `historical_asia` VALUES ('18', '澳门', '0.86', '0.94', '受半球/一球', '0.95', '0.85', '受半球', '12-21 19:57', '12-17 22:30', '825907');
INSERT INTO `historical_asia` VALUES ('19', '皇冠', '0.91', '0.98', '受半球/一球', '0.85', '1.03', '受半球', '12-21 19:57', '12-12 01:57', '825907');
INSERT INTO `historical_asia` VALUES ('20', '威廉希尔', '0.86', '0.92', '受半球/一球', '0.96', '0.81', '受平手/半球', '12-21 19:57', '12-12 01:09', '825907');
INSERT INTO `historical_asia` VALUES ('21', 'Bet365', '1.023', '0.825', '受平手/半球', '0.925', '0.925', '平手', '12-21 19:59', '12-11 23:43', '825909');
INSERT INTO `historical_asia` VALUES ('22', '澳门', '0.9', '0.9', '受平手/半球', '0.87', '0.93', '受平手/半球', '12-18 14:31', '12-17 22:29', '825909');
INSERT INTO `historical_asia` VALUES ('23', '皇冠', '1.05', '0.85', '受平手/半球', '1', '0.88', '平手', '12-21 19:59', '12-12 01:48', '825909');
INSERT INTO `historical_asia` VALUES ('24', '威廉希尔', '0.98', '0.77', '受平手/半球', '0.5', '1.5', '受半球', '12-21 19:58', '12-12 01:09', '825909');
INSERT INTO `historical_asia` VALUES ('25', 'Bet365', '0.875', '0.975', '受平手/半球', '0.875', '0.975', '受平手/半球', '12-21 19:55', '12-11 23:43', '825919');
INSERT INTO `historical_asia` VALUES ('26', '澳门', '0.9', '0.9', '受平手/半球', '0.88', '0.92', '受平手/半球', '12-21 19:59', '12-17 22:29', '825919');
INSERT INTO `historical_asia` VALUES ('27', '皇冠', '0.92', '0.97', '受平手/半球', '0.93', '0.95', '受平手/半球', '12-21 19:47', '12-12 01:54', '825919');
INSERT INTO `historical_asia` VALUES ('28', '威廉希尔', '0.87', '0.9', '受平手/半球', '0.78', '1', '受平手/半球', '12-21 19:58', '12-12 01:09', '825919');
INSERT INTO `historical_asia` VALUES ('29', 'Bet365', '0.86', '1.069', '平手/半球', '0.899', '1', '平手', '12-21 20:29', '12-10 17:40', '806813');
INSERT INTO `historical_asia` VALUES ('30', '澳门', '0.84', '1.02', '平手/半球', '0.8', '1.06', '平手', '12-21 20:10', '12-16 21:10', '806813');
INSERT INTO `historical_asia` VALUES ('31', '皇冠', '0.86', '1.05', '平手/半球', '1.21', '0.7', '平手/半球', '12-21 20:25', '12-10 06:58', '806813');
INSERT INTO `historical_asia` VALUES ('32', '威廉希尔', '0.84', '0.94', '平手/半球', '1.38', '0.53', '半球', '12-21 20:21', '12-08 23:26', '806813');
INSERT INTO `historical_asia` VALUES ('33', 'Bet365', '0.95', '0.899', '半球', '0.85', '1', '半球', '12-21 20:53', '12-15 16:35', '818441');
INSERT INTO `historical_asia` VALUES ('34', '澳门', '0.8', '0.9', '半球', '0.88', '0.82', '半球', '12-21 06:08', '12-19 22:59', '818441');
INSERT INTO `historical_asia` VALUES ('35', '皇冠', '0.99', '0.89', '半球', '0.85', '1.03', '半球', '12-21 20:59', '12-15 20:20', '818441');
INSERT INTO `historical_asia` VALUES ('36', '威廉希尔', '0.85', '0.85', '半球', '0.8', '0.91', '半球', '12-21 19:53', '12-15 17:05', '818441');
INSERT INTO `historical_asia` VALUES ('37', 'Bet365', '0.774', '1.1', '平手', '0.95', '0.899', '平手/半球', '12-21 21:58', '12-18 23:07', '809791');
INSERT INTO `historical_asia` VALUES ('38', '澳门', '1', '0.7', '平手/半球', '0.9', '0.8', '平手/半球', '12-21 21:01', '12-19 23:00', '809791');
INSERT INTO `historical_asia` VALUES ('39', '皇冠', '0.8', '1.08', '平手', '0.96', '0.92', '平手/半球', '12-21 21:56', '12-18 18:11', '809791');
INSERT INTO `historical_asia` VALUES ('40', '威廉希尔', '0.72', '1.05', '平手', '0.89', '0.88', '平手/半球', '12-21 21:59', '12-18 20:18', '809791');
INSERT INTO `historical_asia` VALUES ('41', 'Bet365', '0.899', '0.95', '球半', '0.825', '1.023', '一球', '12-21 21:59', '12-18 23:07', '809795');
INSERT INTO `historical_asia` VALUES ('42', '澳门', '0.65', '1.05', '一球/球半', '0.73', '0.97', '一球', '12-21 21:27', '12-19 22:59', '809795');
INSERT INTO `historical_asia` VALUES ('43', '皇冠', '0.94', '0.94', '球半', '0.91', '0.97', '一球', '12-21 21:58', '12-18 18:10', '809795');
INSERT INTO `historical_asia` VALUES ('44', '威廉希尔', '0.85', '0.85', '球半', '0.77', '1', '一球', '12-21 21:18', '12-18 20:18', '809795');
INSERT INTO `historical_asia` VALUES ('45', 'Bet365', '0.909', '1.02', '平手/半球', '0.82', '1.08', '平手', '12-21 21:57', '12-09 21:48', '854154');
INSERT INTO `historical_asia` VALUES ('46', '澳门', '0.85', '1.01', '平手/半球', '0.82', '1.04', '平手', '12-21 21:43', '12-16 21:10', '854154');
INSERT INTO `historical_asia` VALUES ('47', '皇冠', '0.89', '1.02', '平手/半球', '0.78', '1.11', '平手', '12-21 21:58', '12-09 19:13', '854154');
INSERT INTO `historical_asia` VALUES ('48', '威廉希尔', '0.85', '0.94', '平手/半球', '1.3', '0.57', '半球', '12-21 21:55', '12-09 17:43', '854154');
INSERT INTO `historical_asia` VALUES ('49', 'Bet365', '1.08', '0.85', '平手/半球', '1.1', '0.8', '平手/半球', '12-21 22:56', '12-10 22:44', '806801');
INSERT INTO `historical_asia` VALUES ('50', '澳门', '1.02', '0.84', '平手/半球', '0.8', '1.06', '平手', '12-21 22:47', '12-16 21:14', '806801');
INSERT INTO `historical_asia` VALUES ('51', '皇冠', '1.08', '0.82', '平手/半球', '1.11', '0.78', '平手/半球', '12-21 22:59', '12-09 00:04', '806801');
INSERT INTO `historical_asia` VALUES ('52', '威廉希尔', '1.03', '0.76', '平手/半球', '1.38', '0.53', '半球', '12-21 22:58', '12-08 23:26', '806801');
INSERT INTO `historical_asia` VALUES ('53', 'Bet365', '1', '0.929', '受半球', '0.929', '0.97', '受半球', '12-21 22:58', '12-10 01:03', '806803');
INSERT INTO `historical_asia` VALUES ('54', '澳门', '0.98', '0.88', '受半球', '0.96', '0.9', '受半球', '12-21 22:45', '12-16 21:01', '806803');
INSERT INTO `historical_asia` VALUES ('55', '皇冠', '0.98', '0.93', '受半球', '1.2', '0.71', '受平手/半球', '12-21 22:59', '12-10 01:04', '806803');
INSERT INTO `historical_asia` VALUES ('56', '威廉希尔', '0.85', '0.85', '受半球', '0.8', '0.91', '受半球', '12-21 22:44', '12-08 23:30', '806803');
INSERT INTO `historical_asia` VALUES ('57', 'Bet365', '0.899', '1.029', '平手/半球', '1', '0.899', '平手/半球', '12-21 22:59', '12-09 04:45', '806805');
INSERT INTO `historical_asia` VALUES ('58', '澳门', '0.8', '1.06', '平手/半球', '0.96', '0.9', '平手/半球', '12-21 22:43', '12-16 21:13', '806805');
INSERT INTO `historical_asia` VALUES ('59', '皇冠', '0.9', '1.01', '平手/半球', '0.99', '0.89', '平手/半球', '12-21 22:59', '12-09 00:03', '806805');
INSERT INTO `historical_asia` VALUES ('60', '威廉希尔', '0.8', '1', '平手/半球', '1.25', '0.6', '半球', '12-21 22:58', '12-08 23:26', '806805');
INSERT INTO `historical_asia` VALUES ('61', 'Bet365', '1.049', '0.879', '平手/半球', '0.96', '0.94', '平手/半球', '12-21 22:58', '12-09 04:45', '806807');
INSERT INTO `historical_asia` VALUES ('62', '澳门', '1.06', '0.8', '平手/半球', '0.93', '0.93', '平手/半球', '12-21 22:58', '12-16 21:11', '806807');
INSERT INTO `historical_asia` VALUES ('63', '皇冠', '1.04', '0.87', '平手/半球', '1.21', '0.7', '半球', '12-21 22:59', '12-09 20:55', '806807');
INSERT INTO `historical_asia` VALUES ('64', '威廉希尔', '1.04', '0.77', '平手/半球', '1.2', '0.62', '半球', '12-21 22:58', '12-08 23:26', '806807');
INSERT INTO `historical_asia` VALUES ('65', 'Bet365', '0.87', '1.06', '平手', '1.04', '0.86', '平手/半球', '12-21 22:56', '12-09 05:41', '806819');
INSERT INTO `historical_asia` VALUES ('66', '澳门', '0.88', '0.98', '平手', '1.03', '0.83', '平手/半球', '12-21 22:40', '12-16 21:12', '806819');
INSERT INTO `historical_asia` VALUES ('67', '皇冠', '0.85', '1.06', '平手', '1.02', '0.86', '平手/半球', '12-21 22:59', '12-09 05:43', '806819');
INSERT INTO `historical_asia` VALUES ('68', '威廉希尔', '0.83', '0.96', '平手', '1.2', '0.62', '半球', '12-21 22:58', '12-09 05:35', '806819');
INSERT INTO `historical_asia` VALUES ('69', 'Bet365', '1.023', '0.825', '平手/半球', '0.825', '1.023', '平手/半球', '12-21 22:58', '12-18 23:07', '809803');
INSERT INTO `historical_asia` VALUES ('70', '澳门', '0.8', '0.9', '平手/半球', '0.85', '0.85', '平手/半球', '12-20 06:30', '12-19 23:07', '809803');
INSERT INTO `historical_asia` VALUES ('71', '皇冠', '1.06', '0.82', '平手/半球', '0.89', '0.99', '平手/半球', '12-21 22:58', '12-18 18:12', '809803');
INSERT INTO `historical_asia` VALUES ('72', '威廉希尔', '0.99', '0.78', '平手/半球', '0.75', '1.02', '平手/半球', '12-21 22:58', '12-18 20:18', '809803');
INSERT INTO `historical_asia` VALUES ('73', 'Bet365', '0.975', '0.875', '平手/半球', '1.023', '0.825', '平手/半球', '12-21 22:34', '12-15 14:55', '818443');
INSERT INTO `historical_asia` VALUES ('74', '澳门', '0.88', '0.82', '平手/半球', '0.93', '0.77', '平手/半球', '12-21 17:19', '12-19 23:05', '818443');
INSERT INTO `historical_asia` VALUES ('75', '皇冠', '0.99', '0.89', '平手/半球', '1.05', '0.83', '平手/半球', '12-21 22:19', '12-15 20:25', '818443');
INSERT INTO `historical_asia` VALUES ('76', '威廉希尔', '0.94', '0.83', '平手/半球', '1.3', '0.57', '半球', '12-21 22:58', '12-15 17:05', '818443');
INSERT INTO `historical_asia` VALUES ('77', 'Bet365', '1.049', '0.8', '半球', '0.8', '1.049', '平手/半球', '12-21 22:59', '12-15 16:35', '818445');
INSERT INTO `historical_asia` VALUES ('78', '澳门', '0.83', '0.87', '平手/半球', '0.83', '0.87', '平手/半球', '12-19 23:05', '12-19 23:05', '818445');
INSERT INTO `historical_asia` VALUES ('79', '皇冠', '1.06', '0.82', '半球', '0.82', '1.06', '平手/半球', '12-21 22:58', '12-15 20:25', '818445');
INSERT INTO `historical_asia` VALUES ('80', '威廉希尔', '0.75', '1.01', '平手/半球', '1', '0.73', '半球', '12-21 22:36', '12-15 17:05', '818445');
INSERT INTO `historical_asia` VALUES ('81', 'Bet365', '1', '0.85', '半球', '0.825', '1.023', '半球', '12-21 22:54', '12-21 03:59', '818447');
INSERT INTO `historical_asia` VALUES ('82', '澳门', '0.9', '0.8', '半球', '0.85', '0.85', '半球', '12-21 19:23', '12-20 22:50', '818447');
INSERT INTO `historical_asia` VALUES ('83', '皇冠', '1.03', '0.85', '半球', '0.9', '0.92', '半球', '12-21 22:53', '12-20 22:28', '818447');
INSERT INTO `historical_asia` VALUES ('84', '威廉希尔', '0.91', '0.8', '半球', '0.85', '0.85', '半球', '12-21 19:21', '12-20 19:13', '818447');
INSERT INTO `historical_asia` VALUES ('85', 'Bet365', '0.95', '0.899', '半球', '1', '0.85', '平手/半球', '12-21 22:35', '12-15 18:18', '818449');
INSERT INTO `historical_asia` VALUES ('86', '澳门', '0.76', '0.94', '平手/半球', '0.76', '0.94', '平手/半球', '12-19 23:07', '12-19 23:07', '818449');
INSERT INTO `historical_asia` VALUES ('87', '皇冠', '0.98', '0.9', '半球', '1.02', '0.86', '平手/半球', '12-21 22:40', '12-15 20:25', '818449');
INSERT INTO `historical_asia` VALUES ('88', '威廉希尔', '0.91', '0.8', '半球', '1.25', '0.6', '半球', '12-21 22:22', '12-15 17:05', '818449');
INSERT INTO `historical_asia` VALUES ('89', 'Bet365', '0.925', '0.925', '一球', '0.825', '1.023', '半球/一球', '12-21 22:59', '12-15 18:18', '818451');
INSERT INTO `historical_asia` VALUES ('90', '澳门', '0.93', '0.77', '一球', '0.93', '0.77', '一球', '12-19 23:02', '12-19 23:02', '818451');
INSERT INTO `historical_asia` VALUES ('91', '皇冠', '0.95', '0.93', '一球', '0.84', '1.04', '半球/一球', '12-21 22:55', '12-15 20:22', '818451');
INSERT INTO `historical_asia` VALUES ('92', '威廉希尔', '0.92', '0.84', '一球', '0.57', '1.3', '半球', '12-21 22:58', '12-15 17:05', '818451');
INSERT INTO `historical_asia` VALUES ('93', 'Bet365', '0.975', '0.875', '半球', '1.023', '0.825', '半球', '12-21 22:54', '12-15 14:55', '818453');
INSERT INTO `historical_asia` VALUES ('94', '澳门', '0.95', '0.75', '半球', '0.95', '0.75', '半球', '12-19 23:03', '12-19 23:03', '818453');
INSERT INTO `historical_asia` VALUES ('95', '皇冠', '1.01', '0.87', '半球', '1.04', '0.84', '半球', '12-21 22:54', '12-15 20:23', '818453');
INSERT INTO `historical_asia` VALUES ('96', '威廉希尔', '0.91', '0.8', '半球', '1', '0.73', '半球', '12-21 17:10', '12-15 17:05', '818453');
INSERT INTO `historical_asia` VALUES ('97', 'Bet365', '0.8', '1.049', '受半球', '0.85', '1', '受平手/半球', '12-21 22:59', '12-15 20:21', '818455');
INSERT INTO `historical_asia` VALUES ('98', '澳门', '0.95', '0.75', '受平手/半球', '0.75', '0.95', '受平手/半球', '12-21 19:41', '12-19 23:02', '818455');
INSERT INTO `historical_asia` VALUES ('99', '皇冠', '0.84', '1.04', '受半球', '0.86', '1.02', '受平手/半球', '12-21 22:58', '12-15 20:21', '818455');
INSERT INTO `historical_asia` VALUES ('100', '威廉希尔', '1', '0.76', '受平手/半球', '0.6', '1.25', '受半球', '12-21 22:49', '12-15 17:05', '818455');
INSERT INTO `historical_asia` VALUES ('101', 'Bet365', '0.925', '0.925', '平手/半球', '0.975', '0.875', '半球', '12-21 22:29', '12-15 20:37', '818457');
INSERT INTO `historical_asia` VALUES ('102', '澳门', '0.86', '0.84', '平手/半球', '0.86', '0.84', '平手/半球', '12-19 23:04', '12-19 23:04', '818457');
INSERT INTO `historical_asia` VALUES ('103', '皇冠', '0.96', '0.92', '平手/半球', '0.98', '0.9', '半球', '12-21 22:42', '12-15 20:39', '818457');
INSERT INTO `historical_asia` VALUES ('104', '威廉希尔', '0.92', '0.84', '平手/半球', '0.91', '0.8', '半球', '12-21 22:58', '12-15 17:05', '818457');
INSERT INTO `historical_asia` VALUES ('105', 'Bet365', '1.1', '0.774', '平手/半球', '0.875', '0.975', '平手/半球', '12-21 22:59', '12-15 20:24', '818459');
INSERT INTO `historical_asia` VALUES ('106', '澳门', '0.9', '0.8', '平手/半球', '0.94', '0.76', '平手/半球', '12-21 15:41', '12-19 23:06', '818459');
INSERT INTO `historical_asia` VALUES ('107', '皇冠', '1.11', '0.78', '平手/半球', '0.89', '0.99', '平手/半球', '12-21 22:53', '12-15 20:25', '818459');
INSERT INTO `historical_asia` VALUES ('108', '威廉希尔', '0.95', '0.79', '平手/半球', '0.85', '0.92', '平手/半球', '12-21 22:58', '12-15 17:05', '818459');
INSERT INTO `historical_asia` VALUES ('109', 'Bet365', '1.023', '0.825', '半球', '0.875', '0.975', '平手/半球', '12-21 22:53', '12-15 14:55', '818461');
INSERT INTO `historical_asia` VALUES ('110', '澳门', '0.78', '0.92', '平手/半球', '0.74', '0.96', '平手/半球', '12-21 22:26', '12-19 23:01', '818461');
INSERT INTO `historical_asia` VALUES ('111', '皇冠', '1.02', '0.86', '半球', '0.89', '0.99', '平手/半球', '12-21 22:43', '12-15 20:20', '818461');
INSERT INTO `historical_asia` VALUES ('112', '威廉希尔', '0.74', '1.02', '平手/半球', '0.83', '0.94', '平手/半球', '12-21 22:26', '12-15 17:05', '818461');
INSERT INTO `historical_asia` VALUES ('113', 'Bet365', '0.925', '0.925', '受平手/半球', '0.875', '0.975', '受平手/半球', '12-22 00:59', '12-15 15:27', '827561');
INSERT INTO `historical_asia` VALUES ('114', '澳门', '0.9', '0.9', '受平手/半球', '0.97', '0.83', '受平手/半球', '12-21 23:25', '12-19 23:09', '827561');
INSERT INTO `historical_asia` VALUES ('115', '皇冠', '0.94', '0.95', '受平手/半球', '1.26', '0.67', '平手', '12-22 00:59', '12-15 15:30', '827561');
INSERT INTO `historical_asia` VALUES ('116', '威廉希尔', '0.88', '0.88', '受平手/半球', '0.76', '1.04', '受平手/半球', '12-22 00:56', '12-14 20:39', '827561');
INSERT INTO `historical_asia` VALUES ('117', 'Bet365', '0.889', '1.04', '一球', '1.04', '0.86', '球半/两球', '12-22 00:59', '12-09 21:53', '854152');
INSERT INTO `historical_asia` VALUES ('118', '澳门', '1.12', '0.74', '一球/球半', '1.08', '0.78', '球半', '12-21 23:06', '12-16 21:05', '854152');
INSERT INTO `historical_asia` VALUES ('119', '皇冠', '0.89', '1.02', '一球', '1.03', '0.85', '球半/两球', '12-22 00:59', '12-11 06:14', '854152');
INSERT INTO `historical_asia` VALUES ('120', '威廉希尔', '1.05', '0.78', '一球/球半', '0.7', '1.05', '球半', '12-22 00:55', '12-09 17:43', '854152');
INSERT INTO `historical_asia` VALUES ('121', 'Bet365', '1.089', '0.84', '球半', '1.02', '0.879', '一球/球半', '12-22 01:28', '12-11 06:41', '806811');
INSERT INTO `historical_asia` VALUES ('122', '澳门', '1.08', '0.78', '球半', '0.85', '1.01', '一球/球半', '12-22 01:11', '12-16 21:08', '806811');
INSERT INTO `historical_asia` VALUES ('123', '皇冠', '0.83', '1.08', '一球/球半', '1.03', '0.85', '一球/球半', '12-22 01:29', '12-11 01:00', '806811');
INSERT INTO `historical_asia` VALUES ('124', '威廉希尔', '0.85', '0.85', '球半', '1.1', '0.67', '球半', '12-22 00:51', '12-08 23:56', '806811');
INSERT INTO `historical_asia` VALUES ('125', 'Bet365', '1.049', '0.85', '半球', '0.85', '1.049', '半球', '12-22 01:28', '12-16 06:09', '809107');
INSERT INTO `historical_asia` VALUES ('126', '澳门', '1', '0.8', '半球', '0.96', '0.84', '半球/一球', '12-21 23:29', '12-17 22:15', '809107');
INSERT INTO `historical_asia` VALUES ('127', '皇冠', '0.78', '1.13', '平手/半球', '0.87', '1.01', '半球', '12-22 01:25', '12-16 00:06', '809107');
INSERT INTO `historical_asia` VALUES ('128', '威廉希尔', '0.91', '0.8', '半球', '0.8', '0.91', '半球', '12-21 17:58', '12-16 01:17', '809107');
INSERT INTO `historical_asia` VALUES ('129', 'Bet365', '0.889', '1.009', '受一球', '1.299', '0.675', '受半球/一球', '12-22 02:44', '12-16 06:09', '809109');
INSERT INTO `historical_asia` VALUES ('130', '澳门', '0.9', '0.9', '受一球', '0.99', '0.81', '受一球', '12-22 02:40', '12-17 22:16', '809109');
INSERT INTO `historical_asia` VALUES ('131', '皇冠', '0.89', '1.01', '受一球', '1.05', '0.83', '受半球/一球', '12-22 02:42', '12-16 00:12', '809109');
INSERT INTO `historical_asia` VALUES ('132', '威廉希尔', '0.86', '0.91', '受一球', '0.87', '0.94', '受一球', '12-22 02:42', '12-16 02:23', '809109');
INSERT INTO `historical_asia` VALUES ('133', 'Bet365', '0.98', '0.919', '球半/两球', '1.089', '0.81', '两球', '12-22 02:43', '12-16 06:09', '809111');
INSERT INTO `historical_asia` VALUES ('134', '澳门', '1', '0.8', '球半/两球', '0.8', '1', '球半/两球', '12-22 02:23', '12-17 22:16', '809111');
INSERT INTO `historical_asia` VALUES ('135', '皇冠', '0.98', '0.92', '球半/两球', '0.92', '0.96', '两球', '12-22 02:42', '12-16 00:07', '809111');
INSERT INTO `historical_asia` VALUES ('136', '威廉希尔', '0.87', '0.89', '球半/两球', '0.93', '0.87', '两球', '12-22 02:42', '12-16 02:23', '809111');
INSERT INTO `historical_asia` VALUES ('137', 'Bet365', '1.1', '0.774', '平手', '0.774', '1.1', '受平手/半球', '12-22 02:53', '12-15 17:58', '827553');
INSERT INTO `historical_asia` VALUES ('138', '澳门', '0.74', '1.06', '受平手/半球', '0.78', '1.02', '受平手/半球', '12-22 02:49', '12-19 23:03', '827553');
INSERT INTO `historical_asia` VALUES ('139', '皇冠', '0.8', '1.11', '受平手/半球', '0.82', '1.06', '受平手/半球', '12-22 02:58', '12-15 15:34', '827553');
INSERT INTO `historical_asia` VALUES ('140', '威廉希尔', '0.74', '1.02', '受平手/半球', '1.05', '0.75', '平手', '12-22 02:59', '12-14 20:38', '827553');
INSERT INTO `historical_asia` VALUES ('141', 'Bet365', '1.125', '0.75', '平手/半球', '1.1', '0.774', '平手/半球', '12-22 02:58', '12-15 17:58', '827555');
INSERT INTO `historical_asia` VALUES ('142', '澳门', '0.7', '1.1', '平手', '0.74', '1.06', '平手', '12-21 15:47', '12-19 23:02', '827555');
INSERT INTO `historical_asia` VALUES ('143', '皇冠', '1.16', '0.76', '平手/半球', '1.08', '0.8', '平手/半球', '12-22 02:59', '12-15 15:31', '827555');
INSERT INTO `historical_asia` VALUES ('144', '威廉希尔', '1.03', '0.74', '平手/半球', '1.04', '0.77', '平手/半球', '12-22 02:59', '12-14 21:50', '827555');
INSERT INTO `historical_asia` VALUES ('145', 'Bet365', '0.8', '1.049', '受一球', '0.95', '0.899', '受一球', '12-22 01:24', '12-15 17:58', '827565');
INSERT INTO `historical_asia` VALUES ('146', '澳门', '0.94', '0.86', '受一球', '1.02', '0.78', '受一球', '12-21 06:32', '12-19 23:04', '827565');
INSERT INTO `historical_asia` VALUES ('147', '皇冠', '0.84', '1.06', '受一球', '0.98', '0.9', '受一球', '12-22 03:29', '12-15 15:37', '827565');
INSERT INTO `historical_asia` VALUES ('148', '威廉希尔', '0.76', '1.01', '受一球', '0.91', '0.86', '受一球', '12-22 03:23', '12-14 20:38', '827565');
INSERT INTO `historical_asia` VALUES ('149', 'Bet365', '1.069', '0.83', '一球/球半', '1.04', '0.86', '一球/球半', '12-22 03:43', '12-16 06:09', '809113');
INSERT INTO `historical_asia` VALUES ('150', '澳门', '0.94', '0.86', '一球/球半', '0.96', '0.84', '一球/球半', '12-22 03:42', '12-17 21:56', '809113');
INSERT INTO `historical_asia` VALUES ('151', '皇冠', '0.79', '1.12', '一球', '1.05', '0.83', '一球/球半', '12-22 03:44', '12-16 00:09', '809113');
INSERT INTO `historical_asia` VALUES ('152', '威廉希尔', '0.97', '0.78', '一球/球半', '0.99', '0.8', '一球/球半', '12-22 03:44', '12-16 01:17', '809113');
INSERT INTO `historical_asia` VALUES ('153', 'Bet365', '0.889', '1.04', '半球/一球', '0.95', '0.95', '半球/一球', '12-22 03:43', '12-09 21:50', '854146');
INSERT INTO `historical_asia` VALUES ('154', '澳门', '0.8', '1.06', '半球/一球', '0.98', '0.88', '半球/一球', '12-22 03:26', '12-16 21:12', '854146');
INSERT INTO `historical_asia` VALUES ('155', '皇冠', '0.87', '1.04', '半球/一球', '0.7', '1.21', '半球', '12-22 03:44', '12-09 21:50', '854146');
INSERT INTO `historical_asia` VALUES ('156', '威廉希尔', '0.8', '1', '半球/一球', '0.67', '1.1', '半球', '12-22 03:44', '12-09 17:43', '854146');

-- ----------------------------
-- Table structure for `historical_bigorsmall`
-- ----------------------------
DROP TABLE IF EXISTS `historical_bigorsmall`;
CREATE TABLE `historical_bigorsmall` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` varchar(8) NOT NULL,
  `immediateUpperStage` double NOT NULL,
  `immediateLowerStage` double NOT NULL,
  `immediateOpening` varchar(20) NOT NULL,
  `startUpperStage` double NOT NULL,
  `startLowerStage` double NOT NULL,
  `startOpening` varchar(20) NOT NULL,
  `changedTime` varchar(12) NOT NULL,
  `startTime` varchar(12) NOT NULL,
  `subMatchId_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Historical_bigorsmal_subMatchId_id_986d9b23_fk_Historica` (`subMatchId_id`),
  CONSTRAINT `Historical_bigorsmal_subMatchId_id_986d9b23_fk_Historica` FOREIGN KEY (`subMatchId_id`) REFERENCES `historical_history` (`matchId`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of historical_bigorsmall
-- ----------------------------
INSERT INTO `historical_bigorsmall` VALUES ('1', 'Bet365', '0.95', '0.9', '2.5/3', '0.88', '0.98', '2.5/3', '12-21 11:33', '12-14 06:38', '869884');
INSERT INTO `historical_bigorsmall` VALUES ('2', '澳门', '0.75', '0.95', '2.5/3', '0.79', '0.91', '2.5/3', '12-21 07:49', '12-16 21:07', '869884');
INSERT INTO `historical_bigorsmall` VALUES ('3', '皇冠', '0.96', '0.92', '2.5/3', '0.87', '0.99', '2.5/3', '12-21 11:39', '12-13 21:10', '869884');
INSERT INTO `historical_bigorsmall` VALUES ('4', '威廉希尔', '0.73', '1', '2.5', '0.67', '1.1', '2.5', '12-21 11:27', '12-13 20:00', '869884');
INSERT INTO `historical_bigorsmall` VALUES ('5', 'Bet365', '1.05', '0.8', '3', '0.98', '0.88', '2.5/3', '12-21 13:59', '12-14 06:38', '869882');
INSERT INTO `historical_bigorsmall` VALUES ('6', '澳门', '0.76', '0.94', '2.5/3', '0.91', '0.79', '2.5/3', '12-21 06:08', '12-16 21:08', '869882');
INSERT INTO `historical_bigorsmall` VALUES ('7', '皇冠', '0.8', '1.08', '2.5/3', '0.99', '0.87', '2.5/3', '12-21 13:59', '12-13 21:14', '869882');
INSERT INTO `historical_bigorsmall` VALUES ('8', '威廉希尔', '0.62', '1.2', '2.5', '0.67', '1.1', '2.5', '12-21 04:43', '12-13 20:00', '869882');
INSERT INTO `historical_bigorsmall` VALUES ('9', 'Bet365', '1.05', '0.8', '3', '1.05', '0.8', '3', '12-21 16:21', '12-14 06:38', '869886');
INSERT INTO `historical_bigorsmall` VALUES ('10', '澳门', '0.96', '0.74', '3', '0.96', '0.74', '3', '12-16 21:08', '12-16 21:08', '869886');
INSERT INTO `historical_bigorsmall` VALUES ('11', '皇冠', '0.85', '1.03', '2.5/3', '1.04', '0.82', '3', '12-21 16:29', '12-13 21:14', '869886');
INSERT INTO `historical_bigorsmall` VALUES ('12', '威廉希尔', '0.6', '1.25', '2.5', '1.5', '0.5', '3.5', '12-21 13:25', '12-13 20:00', '869886');
INSERT INTO `historical_bigorsmall` VALUES ('13', 'Bet365', '0.88', '0.98', '2.5', '0.9', '0.95', '2.5', '12-21 19:40', '12-12 02:01', '825903');
INSERT INTO `historical_bigorsmall` VALUES ('14', '澳门', '0.8', '0.9', '2.5', '0.8', '0.9', '2.5', '12-17 22:31', '12-17 22:31', '825903');
INSERT INTO `historical_bigorsmall` VALUES ('15', '皇冠', '0.87', '1.01', '2.5', '0.93', '0.93', '2.5', '12-21 19:54', '12-12 02:02', '825903');
INSERT INTO `historical_bigorsmall` VALUES ('16', '威廉希尔', '2', '0.36', '3.5', '2', '0.36', '3.5', '12-12 01:09', '12-12 01:09', '825903');
INSERT INTO `historical_bigorsmall` VALUES ('17', 'Bet365', '1.02', '0.82', '2.5/3', '0.9', '0.95', '2.5', '12-21 19:44', '12-12 01:57', '825907');
INSERT INTO `historical_bigorsmall` VALUES ('18', '澳门', '0.8', '0.9', '2.5', '0.8', '0.9', '2.5', '12-17 22:30', '12-17 22:30', '825907');
INSERT INTO `historical_bigorsmall` VALUES ('19', '皇冠', '0.82', '1.06', '2.5', '0.88', '0.98', '2.5', '12-21 19:57', '12-12 01:57', '825907');
INSERT INTO `historical_bigorsmall` VALUES ('20', '威廉希尔', '0.8', '0.91', '2.5', '2.25', '0.33', '3.5', '12-20 19:01', '12-12 01:09', '825907');
INSERT INTO `historical_bigorsmall` VALUES ('21', 'Bet365', '0.8', '1.05', '2.5/3', '0.98', '0.88', '2.5/3', '12-21 19:56', '12-11 23:43', '825909');
INSERT INTO `historical_bigorsmall` VALUES ('22', '澳门', '0.83', '0.87', '2.5/3', '0.85', '0.85', '2.5/3', '12-21 19:55', '12-17 22:28', '825909');
INSERT INTO `historical_bigorsmall` VALUES ('23', '皇冠', '0.84', '1.04', '2.5/3', '0.98', '0.88', '2.5/3', '12-21 19:59', '12-12 01:48', '825909');
INSERT INTO `historical_bigorsmall` VALUES ('24', '威廉希尔', '0.67', '1.1', '2.5', '0.73', '1', '2.5', '12-21 17:50', '12-12 01:09', '825909');
INSERT INTO `historical_bigorsmall` VALUES ('25', 'Bet365', '0.95', '0.9', '2.5', '0.95', '0.9', '2.5/3', '12-21 19:54', '12-12 05:44', '825919');
INSERT INTO `historical_bigorsmall` VALUES ('26', '澳门', '0.92', '0.78', '2.5/3', '0.92', '0.78', '2.5/3', '12-17 22:30', '12-17 22:30', '825919');
INSERT INTO `historical_bigorsmall` VALUES ('27', '皇冠', '0.98', '0.9', '2.5', '0.94', '0.92', '2.5/3', '12-21 19:58', '12-12 06:19', '825919');
INSERT INTO `historical_bigorsmall` VALUES ('28', '威廉希尔', '0.91', '0.8', '2.5', '8', '0.05', '5.5', '12-21 19:58', '12-12 01:09', '825919');
INSERT INTO `historical_bigorsmall` VALUES ('29', 'Bet365', '0.85', '1.05', '3', '1.01', '0.89', '3', '12-21 20:24', '12-09 04:45', '806813');
INSERT INTO `historical_bigorsmall` VALUES ('30', '澳门', '0.82', '0.98', '3', '0.92', '0.88', '3', '12-21 15:32', '12-16 21:10', '806813');
INSERT INTO `historical_bigorsmall` VALUES ('31', '皇冠', '0.85', '1.05', '3', '0.96', '0.9', '3', '12-21 20:29', '12-08 23:01', '806813');
INSERT INTO `historical_bigorsmall` VALUES ('32', '威廉希尔', '1.47', '0.64', '3.5', '0.6', '1.25', '2.5', '12-21 17:15', '12-08 23:26', '806813');
INSERT INTO `historical_bigorsmall` VALUES ('33', 'Bet365', '0.82', '1.02', '2/2.5', '0.82', '1.02', '2/2.5', '12-21 20:46', '12-15 14:55', '818441');
INSERT INTO `historical_bigorsmall` VALUES ('34', '澳门', '0.69', '0.91', '2/2.5', '0.69', '0.91', '2/2.5', '12-19 22:59', '12-19 22:59', '818441');
INSERT INTO `historical_bigorsmall` VALUES ('35', '皇冠', '1.06', '0.8', '2.5', '0.95', '0.91', '2/2.5', '12-21 20:55', '12-15 20:20', '818441');
INSERT INTO `historical_bigorsmall` VALUES ('36', '威廉希尔', '1.05', '0.7', '2.5', '1.1', '0.67', '2.5', '12-18 18:02', '12-15 17:05', '818441');
INSERT INTO `historical_bigorsmall` VALUES ('37', 'Bet365', '0.95', '0.9', '2/2.5', '0.85', '1', '2', '12-21 21:55', '12-20 00:57', '809791');
INSERT INTO `historical_bigorsmall` VALUES ('38', '澳门', '0.68', '0.92', '2', '0.68', '0.92', '2', '12-19 23:00', '12-19 23:00', '809791');
INSERT INTO `historical_bigorsmall` VALUES ('39', '皇冠', '0.95', '0.91', '2/2.5', '1.06', '0.8', '2/2.5', '12-21 21:45', '12-18 18:11', '809791');
INSERT INTO `historical_bigorsmall` VALUES ('40', '威廉希尔', '1.2', '0.62', '2.5', '1.38', '0.53', '2.5', '12-21 21:59', '12-18 20:18', '809791');
INSERT INTO `historical_bigorsmall` VALUES ('41', 'Bet365', '0.8', '1.05', '2.5', '0.88', '0.98', '2/2.5', '12-21 21:59', '12-19 00:03', '809795');
INSERT INTO `historical_bigorsmall` VALUES ('42', '澳门', '0.75', '0.85', '2.5', '0.75', '0.85', '2/2.5', '12-21 21:27', '12-19 22:59', '809795');
INSERT INTO `historical_bigorsmall` VALUES ('43', '皇冠', '1.03', '0.83', '2.5/3', '0.89', '0.97', '2/2.5', '12-21 21:56', '12-18 18:10', '809795');
INSERT INTO `historical_bigorsmall` VALUES ('44', '威廉希尔', '0.8', '0.91', '2.5', '1.1', '0.67', '2.5', '12-21 17:54', '12-18 20:18', '809795');
INSERT INTO `historical_bigorsmall` VALUES ('45', 'Bet365', '1.06', '0.84', '2.5', '0.97', '0.93', '2.5', '12-21 21:59', '12-10 22:53', '854154');
INSERT INTO `historical_bigorsmall` VALUES ('46', '澳门', '1.04', '0.76', '2.5', '0.86', '0.94', '2.5', '12-21 21:24', '12-16 21:10', '854154');
INSERT INTO `historical_bigorsmall` VALUES ('47', '皇冠', '1.06', '0.84', '2.5', '1.2', '0.69', '2.5/3', '12-21 21:58', '12-09 21:49', '854154');
INSERT INTO `historical_bigorsmall` VALUES ('48', '威廉希尔', '1.05', '0.7', '2.5', '0.91', '0.8', '2.5', '12-21 21:14', '12-09 17:43', '854154');
INSERT INTO `historical_bigorsmall` VALUES ('49', 'Bet365', '0.84', '1.06', '2', '1.09', '0.81', '2/2.5', '12-21 22:58', '12-09 04:45', '806801');
INSERT INTO `historical_bigorsmall` VALUES ('50', '澳门', '0.8', '1', '2', '0.74', '1.06', '2', '12-21 22:45', '12-16 21:14', '806801');
INSERT INTO `historical_bigorsmall` VALUES ('51', '皇冠', '0.84', '1.06', '2', '1.06', '0.8', '2/2.5', '12-21 22:56', '12-09 00:04', '806801');
INSERT INTO `historical_bigorsmall` VALUES ('52', '威廉希尔', '1.38', '0.53', '2.5', '1.25', '0.6', '2.5', '12-21 22:58', '12-08 23:26', '806801');
INSERT INTO `historical_bigorsmall` VALUES ('53', 'Bet365', '0.86', '1.04', '2.5', '1.02', '0.88', '2.5/3', '12-21 22:52', '12-10 01:00', '806803');
INSERT INTO `historical_bigorsmall` VALUES ('54', '澳门', '1.04', '0.76', '2.5/3', '0.95', '0.85', '2.5/3', '12-21 22:46', '12-16 21:01', '806803');
INSERT INTO `historical_bigorsmall` VALUES ('55', '皇冠', '0.85', '1.05', '2.5', '0.98', '0.88', '2.5/3', '12-21 22:55', '12-10 01:01', '806803');
INSERT INTO `historical_bigorsmall` VALUES ('56', '威廉希尔', '0.8', '0.91', '2.5', '0.8', '0.91', '2.5', '12-08 23:25', '12-08 23:25', '806803');
INSERT INTO `historical_bigorsmall` VALUES ('57', 'Bet365', '1.05', '0.85', '2.5', '0.93', '0.97', '2/2.5', '12-21 22:59', '12-09 04:45', '806805');
INSERT INTO `historical_bigorsmall` VALUES ('58', '澳门', '0.66', '1.14', '2/2.5', '0.88', '0.92', '2/2.5', '12-21 22:43', '12-16 21:13', '806805');
INSERT INTO `historical_bigorsmall` VALUES ('59', '皇冠', '1.04', '0.86', '2.5', '0.9', '0.96', '2/2.5', '12-21 22:59', '12-09 00:03', '806805');
INSERT INTO `historical_bigorsmall` VALUES ('60', '威廉希尔', '1', '0.73', '2.5', '1.05', '0.7', '2.5', '12-21 19:04', '12-08 23:26', '806805');
INSERT INTO `historical_bigorsmall` VALUES ('61', 'Bet365', '1.09', '0.81', '2.5', '0.88', '1.02', '2.5', '12-21 22:52', '12-09 20:54', '806807');
INSERT INTO `historical_bigorsmall` VALUES ('62', '澳门', '1.02', '0.78', '2.5', '0.82', '0.98', '2.5', '12-21 22:39', '12-16 21:11', '806807');
INSERT INTO `historical_bigorsmall` VALUES ('63', '皇冠', '0.83', '1.07', '2/2.5', '1.05', '0.81', '2.5/3', '12-21 22:57', '12-09 20:55', '806807');
INSERT INTO `historical_bigorsmall` VALUES ('64', '威廉希尔', '1', '0.73', '2.5', '2', '0.36', '3.5', '12-21 18:03', '12-08 23:26', '806807');
INSERT INTO `historical_bigorsmall` VALUES ('65', 'Bet365', '1.02', '0.88', '3', '0.84', '1.06', '2.5/3', '12-21 22:54', '12-09 04:45', '806819');
INSERT INTO `historical_bigorsmall` VALUES ('66', '澳门', '0.98', '0.82', '3', '0.78', '1.02', '2.5/3', '12-21 22:41', '12-16 21:12', '806819');
INSERT INTO `historical_bigorsmall` VALUES ('67', '皇冠', '1.02', '0.88', '3', '0.83', '1.03', '2.5/3', '12-21 22:58', '12-09 04:27', '806819');
INSERT INTO `historical_bigorsmall` VALUES ('68', '威廉希尔', '0.67', '1.1', '2.5', '1.62', '0.44', '3.5', '12-09 00:12', '12-08 23:57', '806819');
INSERT INTO `historical_bigorsmall` VALUES ('69', 'Bet365', '0.85', '1', '1.5/2', '0.77', '1.1', '1.5/2', '12-21 22:58', '12-20 00:23', '809803');
INSERT INTO `historical_bigorsmall` VALUES ('70', '澳门', '0.92', '0.68', '2', '0.92', '0.68', '2', '12-19 23:07', '12-19 23:07', '809803');
INSERT INTO `historical_bigorsmall` VALUES ('71', '皇冠', '0.83', '1.03', '1.5/2', '1.04', '0.82', '2', '12-21 22:58', '12-18 18:12', '809803');
INSERT INTO `historical_bigorsmall` VALUES ('72', '威廉希尔', '0.6', '1.25', '1.5', '4', '0.14', '3.5', '12-21 10:45', '12-18 20:18', '809803');
INSERT INTO `historical_bigorsmall` VALUES ('73', 'Bet365', '0.82', '1.02', '2/2.5', '0.9', '0.95', '2.5', '12-21 22:59', '12-15 14:55', '818443');
INSERT INTO `historical_bigorsmall` VALUES ('74', '澳门', '0.91', '0.69', '2.5', '0.91', '0.69', '2.5', '12-19 23:05', '12-19 23:05', '818443');
INSERT INTO `historical_bigorsmall` VALUES ('75', '皇冠', '0.85', '1.01', '2/2.5', '0.87', '0.99', '2.5', '12-21 22:59', '12-15 20:25', '818443');
INSERT INTO `historical_bigorsmall` VALUES ('76', '威廉希尔', '1', '0.73', '2.5', '0.85', '0.85', '2.5', '12-21 17:54', '12-15 17:05', '818443');
INSERT INTO `historical_bigorsmall` VALUES ('77', 'Bet365', '1.02', '0.82', '2.5', '1.02', '0.82', '2.5', '12-21 19:09', '12-15 14:55', '818445');
INSERT INTO `historical_bigorsmall` VALUES ('78', '澳门', '0.85', '0.75', '2.5', '0.85', '0.75', '2.5', '12-19 23:05', '12-19 23:05', '818445');
INSERT INTO `historical_bigorsmall` VALUES ('79', '皇冠', '1.04', '0.82', '2.5', '0.89', '0.97', '2/2.5', '12-21 21:36', '12-15 20:25', '818445');
INSERT INTO `historical_bigorsmall` VALUES ('80', '威廉希尔', '0.91', '0.8', '2.5', '1', '0.73', '2.5', '12-21 20:34', '12-15 17:05', '818445');
INSERT INTO `historical_bigorsmall` VALUES ('81', 'Bet365', '1.02', '0.82', '2.5/3', '0.98', '0.88', '2.5/3', '12-21 16:43', '12-21 03:59', '818447');
INSERT INTO `historical_bigorsmall` VALUES ('82', '澳门', '0.84', '0.76', '2.5/3', '0.84', '0.76', '2.5/3', '12-20 22:50', '12-20 22:50', '818447');
INSERT INTO `historical_bigorsmall` VALUES ('83', '皇冠', '1.03', '0.83', '2.5/3', '0.91', '0.89', '2.5/3', '12-21 17:05', '12-20 22:28', '818447');
INSERT INTO `historical_bigorsmall` VALUES ('84', '威廉希尔', '0.73', '1', '2.5', '0.73', '1', '2.5', '12-20 20:34', '12-16 17:27', '818447');
INSERT INTO `historical_bigorsmall` VALUES ('85', 'Bet365', '0.85', '1', '2.5', '0.88', '0.98', '2.5', '12-21 18:40', '12-15 14:55', '818449');
INSERT INTO `historical_bigorsmall` VALUES ('86', '澳门', '0.76', '0.84', '2.5', '0.76', '0.84', '2.5', '12-19 23:07', '12-19 23:07', '818449');
INSERT INTO `historical_bigorsmall` VALUES ('87', '皇冠', '0.86', '1', '2.5', '0.88', '0.98', '2.5', '12-21 21:37', '12-15 20:25', '818449');
INSERT INTO `historical_bigorsmall` VALUES ('88', '威廉希尔', '2', '0.36', '3.5', '2', '0.36', '3.5', '12-15 17:05', '12-15 17:05', '818449');
INSERT INTO `historical_bigorsmall` VALUES ('89', 'Bet365', '0.95', '0.9', '2.5/3', '1.05', '0.8', '2.5', '12-21 22:55', '12-15 14:55', '818451');
INSERT INTO `historical_bigorsmall` VALUES ('90', '澳门', '0.85', '0.75', '2.5/3', '0.79', '0.81', '2.5', '12-21 17:55', '12-19 23:02', '818451');
INSERT INTO `historical_bigorsmall` VALUES ('91', '皇冠', '0.95', '0.91', '2.5/3', '0.83', '1.03', '2/2.5', '12-21 22:55', '12-15 20:22', '818451');
INSERT INTO `historical_bigorsmall` VALUES ('92', '威廉希尔', '0.73', '1', '2.5', '1', '0.73', '2.5', '12-21 17:50', '12-15 17:05', '818451');
INSERT INTO `historical_bigorsmall` VALUES ('93', 'Bet365', '0.98', '0.88', '2/2.5', '1', '0.85', '2/2.5', '12-21 22:44', '12-15 14:55', '818453');
INSERT INTO `historical_bigorsmall` VALUES ('94', '澳门', '0.79', '0.81', '2/2.5', '0.79', '0.81', '2/2.5', '12-19 23:03', '12-19 23:03', '818453');
INSERT INTO `historical_bigorsmall` VALUES ('95', '皇冠', '1', '0.86', '2/2.5', '1.07', '0.79', '2/2.5', '12-21 22:41', '12-15 20:23', '818453');
INSERT INTO `historical_bigorsmall` VALUES ('96', '威廉希尔', '1.2', '0.62', '2.5', '1.25', '0.6', '2.5', '12-21 12:43', '12-15 17:05', '818453');
INSERT INTO `historical_bigorsmall` VALUES ('97', 'Bet365', '0.93', '0.93', '2.5/3', '0.88', '0.98', '2.5', '12-21 22:25', '12-15 14:55', '818455');
INSERT INTO `historical_bigorsmall` VALUES ('98', '澳门', '0.82', '0.78', '2.5/3', '0.82', '0.78', '2.5/3', '12-19 23:02', '12-19 23:02', '818455');
INSERT INTO `historical_bigorsmall` VALUES ('99', '皇冠', '0.91', '0.95', '2.5/3', '1', '0.86', '2.5/3', '12-21 22:22', '12-15 20:21', '818455');
INSERT INTO `historical_bigorsmall` VALUES ('100', '威廉希尔', '0.73', '1', '2.5', '0.73', '1', '2.5', '12-21 12:13', '12-15 17:05', '818455');
INSERT INTO `historical_bigorsmall` VALUES ('101', 'Bet365', '0.85', '1', '2.5/3', '0.82', '1.02', '2.5', '12-21 22:42', '12-15 14:55', '818457');
INSERT INTO `historical_bigorsmall` VALUES ('102', '澳门', '0.82', '0.78', '2.5/3', '0.82', '0.78', '2.5/3', '12-19 23:04', '12-19 23:04', '818457');
INSERT INTO `historical_bigorsmall` VALUES ('103', '皇冠', '0.84', '1.02', '2.5/3', '0.89', '0.97', '2.5', '12-21 22:42', '12-15 20:24', '818457');
INSERT INTO `historical_bigorsmall` VALUES ('104', '威廉希尔', '0.7', '1.05', '2.5', '0.8', '0.91', '2.5', '12-21 17:33', '12-15 17:05', '818457');
INSERT INTO `historical_bigorsmall` VALUES ('105', 'Bet365', '0.95', '0.9', '2.5', '0.85', '1', '2.5', '12-21 22:23', '12-15 14:55', '818459');
INSERT INTO `historical_bigorsmall` VALUES ('106', '澳门', '0.9', '0.7', '2.5', '0.79', '0.81', '2.5', '12-21 15:42', '12-19 23:06', '818459');
INSERT INTO `historical_bigorsmall` VALUES ('107', '皇冠', '0.94', '0.92', '2.5', '0.86', '1', '2.5', '12-21 22:22', '12-15 20:25', '818459');
INSERT INTO `historical_bigorsmall` VALUES ('108', '威廉希尔', '0.8', '0.91', '2.5', '0.8', '0.91', '2.5', '12-15 17:05', '12-15 17:05', '818459');
INSERT INTO `historical_bigorsmall` VALUES ('109', 'Bet365', '1.12', '0.75', '2/2.5', '0.93', '0.93', '2/2.5', '12-21 21:15', '12-15 14:55', '818461');
INSERT INTO `historical_bigorsmall` VALUES ('110', '澳门', '0.9', '0.7', '2/2.5', '0.9', '0.7', '2/2.5', '12-19 23:01', '12-19 23:01', '818461');
INSERT INTO `historical_bigorsmall` VALUES ('111', '皇冠', '0.79', '1.07', '2', '0.95', '0.91', '2/2.5', '12-21 22:43', '12-15 20:20', '818461');
INSERT INTO `historical_bigorsmall` VALUES ('112', '威廉希尔', '1.38', '0.53', '2.5', '1.1', '0.67', '2.5', '12-21 15:21', '12-15 17:05', '818461');
INSERT INTO `historical_bigorsmall` VALUES ('113', 'Bet365', '1.02', '0.82', '2.5', '0.88', '0.98', '2.5', '12-22 00:58', '12-15 12:04', '827561');
INSERT INTO `historical_bigorsmall` VALUES ('114', '澳门', '0.82', '0.88', '2.5', '0.82', '0.88', '2.5', '12-19 23:09', '12-19 23:09', '827561');
INSERT INTO `historical_bigorsmall` VALUES ('115', '皇冠', '1.05', '0.82', '2.5', '0.9', '0.96', '2.5', '12-22 00:51', '12-15 15:25', '827561');
INSERT INTO `historical_bigorsmall` VALUES ('116', '威廉希尔', '1', '0.73', '2.5', '0.8', '0.91', '2.5', '12-22 00:56', '12-14 20:39', '827561');
INSERT INTO `historical_bigorsmall` VALUES ('117', 'Bet365', '1.04', '0.86', '2.5/3', '0.91', '0.99', '3', '12-22 00:56', '12-11 06:13', '854152');
INSERT INTO `historical_bigorsmall` VALUES ('118', '澳门', '0.96', '0.84', '2.5/3', '0.97', '0.83', '3', '12-22 00:57', '12-16 21:05', '854152');
INSERT INTO `historical_bigorsmall` VALUES ('119', '皇冠', '1.04', '0.86', '2.5/3', '0.9', '0.96', '3', '12-22 00:54', '12-11 06:14', '854152');
INSERT INTO `historical_bigorsmall` VALUES ('120', '威廉希尔', '0.73', '1', '2.5', '6.5', '0.07', '5.5', '12-21 21:23', '12-09 17:43', '854152');
INSERT INTO `historical_bigorsmall` VALUES ('121', 'Bet365', '0.97', '0.93', '3.5', '0.84', '1.06', '3', '12-22 01:26', '12-09 21:00', '806811');
INSERT INTO `historical_bigorsmall` VALUES ('122', '澳门', '0.76', '1.04', '3/3.5', '0.97', '0.83', '3/3.5', '12-22 00:55', '12-16 21:08', '806811');
INSERT INTO `historical_bigorsmall` VALUES ('123', '皇冠', '0.97', '0.93', '3.5', '0.83', '1.03', '3', '12-22 01:29', '12-09 21:00', '806811');
INSERT INTO `historical_bigorsmall` VALUES ('124', '威廉希尔', '0.91', '0.8', '3.5', '1.2', '0.62', '3.5', '12-21 15:00', '12-09 02:03', '806811');
INSERT INTO `historical_bigorsmall` VALUES ('125', 'Bet365', '0.95', '0.9', '3', '0.82', '1.02', '3', '12-22 01:23', '12-16 10:24', '809107');
INSERT INTO `historical_bigorsmall` VALUES ('126', '澳门', '0.76', '0.94', '3', '0.95', '0.75', '3/3.5', '12-21 18:17', '12-17 22:15', '809107');
INSERT INTO `historical_bigorsmall` VALUES ('127', '皇冠', '0.96', '0.92', '3', '0.82', '1.04', '3', '12-22 01:27', '12-16 00:22', '809107');
INSERT INTO `historical_bigorsmall` VALUES ('128', '威廉希尔', '0.6', '1.25', '2.5', '1.2', '0.62', '3.5', '12-21 23:38', '12-16 01:17', '809107');
INSERT INTO `historical_bigorsmall` VALUES ('129', 'Bet365', '0.95', '0.9', '3', '0.82', '1.02', '3', '12-22 02:32', '12-16 12:56', '809109');
INSERT INTO `historical_bigorsmall` VALUES ('130', '澳门', '0.78', '0.92', '3', '0.77', '0.93', '3', '12-18 14:33', '12-17 22:16', '809109');
INSERT INTO `historical_bigorsmall` VALUES ('131', '皇冠', '0.98', '0.9', '3', '0.83', '1.03', '3', '12-22 02:41', '12-16 00:07', '809109');
INSERT INTO `historical_bigorsmall` VALUES ('132', '威廉希尔', '0.53', '1.38', '2.5', '1.2', '0.62', '3.5', '12-21 20:15', '12-16 01:17', '809109');
INSERT INTO `historical_bigorsmall` VALUES ('133', 'Bet365', '0.95', '0.9', '3.5', '0.9', '0.95', '3.5', '12-22 02:08', '12-16 09:50', '809111');
INSERT INTO `historical_bigorsmall` VALUES ('134', '澳门', '0.82', '0.88', '3.5', '0.84', '0.86', '3.5', '12-22 00:57', '12-17 22:15', '809111');
INSERT INTO `historical_bigorsmall` VALUES ('135', '皇冠', '0.97', '0.91', '3.5', '0.87', '0.99', '3.5', '12-22 02:40', '12-16 09:50', '809111');
INSERT INTO `historical_bigorsmall` VALUES ('136', '威廉希尔', '0.91', '0.8', '3.5', '0.8', '0.91', '3.5', '12-21 12:00', '12-16 01:17', '809111');
INSERT INTO `historical_bigorsmall` VALUES ('137', 'Bet365', '1', '0.85', '3', '0.98', '0.88', '3', '12-21 23:48', '12-15 12:04', '827553');
INSERT INTO `historical_bigorsmall` VALUES ('138', '澳门', '0.88', '0.82', '3', '0.9', '0.8', '3', '12-22 00:57', '12-19 23:03', '827553');
INSERT INTO `historical_bigorsmall` VALUES ('139', '皇冠', '1', '0.87', '3', '1.01', '0.85', '3', '12-22 02:55', '12-15 15:34', '827553');
INSERT INTO `historical_bigorsmall` VALUES ('140', '威廉希尔', '0.6', '1.25', '2.5', '1.38', '0.53', '3.5', '12-14 20:38', '12-14 20:38', '827553');
INSERT INTO `historical_bigorsmall` VALUES ('141', 'Bet365', '0.85', '1', '2/2.5', '0.9', '0.95', '2.5', '12-22 02:55', '12-15 12:04', '827555');
INSERT INTO `historical_bigorsmall` VALUES ('142', '澳门', '0.95', '0.75', '2.5', '0.78', '0.92', '2.5', '12-22 01:25', '12-19 23:02', '827555');
INSERT INTO `historical_bigorsmall` VALUES ('143', '皇冠', '0.87', '1', '2/2.5', '0.9', '0.96', '2.5', '12-22 02:54', '12-15 15:31', '827555');
INSERT INTO `historical_bigorsmall` VALUES ('144', '威廉希尔', '1.05', '0.7', '2.5', '0.8', '0.91', '2.5', '12-22 01:03', '12-14 20:38', '827555');
INSERT INTO `historical_bigorsmall` VALUES ('145', 'Bet365', '1.02', '0.82', '2.5/3', '0.85', '1', '3', '12-22 03:23', '12-15 12:04', '827565');
INSERT INTO `historical_bigorsmall` VALUES ('146', '澳门', '0.86', '0.84', '2.5/3', '0.85', '0.85', '3', '12-21 22:25', '12-19 23:04', '827565');
INSERT INTO `historical_bigorsmall` VALUES ('147', '皇冠', '1.05', '0.82', '2.5/3', '0.85', '1.01', '3', '12-22 03:28', '12-15 15:37', '827565');
INSERT INTO `historical_bigorsmall` VALUES ('148', '威廉希尔', '0.73', '1', '2.5', '2.75', '0.25', '4.5', '12-21 18:51', '12-14 20:38', '827565');
INSERT INTO `historical_bigorsmall` VALUES ('149', 'Bet365', '1.02', '0.82', '3/3.5', '1.02', '0.82', '3/3.5', '12-21 18:13', '12-16 10:50', '809113');
INSERT INTO `historical_bigorsmall` VALUES ('150', '澳门', '0.8', '0.9', '3/3.5', '0.96', '0.74', '3/3.5', '12-22 03:30', '12-17 21:56', '809113');
INSERT INTO `historical_bigorsmall` VALUES ('151', '皇冠', '1.04', '0.84', '3/3.5', '1.04', '0.82', '3/3.5', '12-22 03:40', '12-16 00:09', '809113');
INSERT INTO `historical_bigorsmall` VALUES ('152', '威廉希尔', '1.2', '0.62', '3.5', '1.2', '0.62', '3.5', '12-16 01:17', '12-16 01:17', '809113');
INSERT INTO `historical_bigorsmall` VALUES ('153', 'Bet365', '0.84', '1.06', '2/2.5', '1.06', '0.84', '2.5', '12-22 03:40', '12-09 17:34', '854146');
INSERT INTO `historical_bigorsmall` VALUES ('154', '澳门', '1', '0.8', '2.5', '1.02', '0.78', '2.5', '12-21 15:57', '12-16 21:12', '854146');
INSERT INTO `historical_bigorsmall` VALUES ('155', '皇冠', '0.85', '1.05', '2/2.5', '1.04', '0.82', '2.5', '12-22 03:44', '12-09 19:15', '854146');
INSERT INTO `historical_bigorsmall` VALUES ('156', '威廉希尔', '1', '0.73', '2.5', '2.4', '0.3', '3.5', '12-09 17:43', '12-09 17:42', '854146');

-- ----------------------------
-- Table structure for `historical_european`
-- ----------------------------
DROP TABLE IF EXISTS `historical_european`;
CREATE TABLE `historical_european` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` varchar(8) NOT NULL,
  `immediateWin` double NOT NULL,
  `immediatePeace` double NOT NULL,
  `immediateLose` double NOT NULL,
  `startWin` double NOT NULL,
  `startPeace` double NOT NULL,
  `startLose` double NOT NULL,
  `subMatchId_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Historical_european_subMatchId_id_2ae724a2_fk_Historica` (`subMatchId_id`),
  CONSTRAINT `Historical_european_subMatchId_id_2ae724a2_fk_Historica` FOREIGN KEY (`subMatchId_id`) REFERENCES `historical_history` (`matchId`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of historical_european
-- ----------------------------
INSERT INTO `historical_european` VALUES ('1', 'Bet365', '3.6', '3.5', '2', '3.5', '3.4', '2.1', '869884');
INSERT INTO `historical_european` VALUES ('2', '澳门', '2.9', '3.51', '2.1', '2.9', '3.51', '2.1', '869884');
INSERT INTO `historical_european` VALUES ('3', '皇冠', '3.35', '3.75', '2.06', '3.5', '3.65', '2.09', '869884');
INSERT INTO `historical_european` VALUES ('4', '威廉希尔', '3.4', '3.6', '1.95', '3.5', '3.5', '1.95', '869884');
INSERT INTO `historical_european` VALUES ('5', 'Bet365', '2.05', '3.5', '3.6', '1.9', '3.75', '3.8', '869882');
INSERT INTO `historical_european` VALUES ('6', '澳门', '1.85', '3.52', '3.52', '1.8', '3.5', '3.75', '869882');
INSERT INTO `historical_european` VALUES ('7', '皇冠', '1.95', '3.75', '3.7', '1.9', '3.9', '3.85', '869882');
INSERT INTO `historical_european` VALUES ('8', '威廉希尔', '1.95', '3.5', '3.5', '1.85', '3.75', '3.7', '869882');
INSERT INTO `historical_european` VALUES ('9', 'Bet365', '1.66', '4', '4.75', '1.6', '4', '5.5', '869886');
INSERT INTO `historical_european` VALUES ('10', '澳门', '1.58', '3.91', '4.55', '1.55', '3.9', '4.85', '869886');
INSERT INTO `historical_european` VALUES ('11', '皇冠', '1.74', '4', '4.4', '1.71', '4.1', '4.7', '869886');
INSERT INTO `historical_european` VALUES ('12', '威廉希尔', '1.7', '3.7', '4.5', '1.65', '3.8', '4.75', '869886');
INSERT INTO `historical_european` VALUES ('13', 'Bet365', '2.25', '3.25', '3.2', '2.55', '3.25', '2.75', '825903');
INSERT INTO `historical_european` VALUES ('14', '澳门', '2.3', '3.13', '2.83', '2.5', '3.15', '2.6', '825903');
INSERT INTO `historical_european` VALUES ('15', '皇冠', '2.16', '3.4', '3.1', '2.63', '3.3', '2.7', '825903');
INSERT INTO `historical_european` VALUES ('16', '威廉希尔', '2.1', '3.3', '3.4', '2.6', '3.2', '2.7', '825903');
INSERT INTO `historical_european` VALUES ('17', 'Bet365', '4', '3.5', '1.9', '5', '3.75', '1.7', '825907');
INSERT INTO `historical_european` VALUES ('18', '澳门', '3.75', '3.43', '1.82', '4.4', '3.65', '1.65', '825907');
INSERT INTO `historical_european` VALUES ('19', '皇冠', '3.35', '3.45', '2.03', '4.7', '3.75', '1.75', '825907');
INSERT INTO `historical_european` VALUES ('20', '威廉希尔', '3.4', '3.3', '2.1', '4.8', '3.6', '1.7', '825907');
INSERT INTO `historical_european` VALUES ('21', 'Bet365', '2.87', '3.4', '2.37', '3.5', '3.6', '2', '825909');
INSERT INTO `historical_european` VALUES ('22', '澳门', '2.82', '3.47', '2.15', '3.05', '3.5', '2.02', '825909');
INSERT INTO `historical_european` VALUES ('23', '皇冠', '2.65', '3.55', '2.38', '3.3', '3.65', '2.11', '825909');
INSERT INTO `historical_european` VALUES ('24', '威廉希尔', '2.6', '3.3', '2.6', '3.4', '3.5', '2.05', '825909');
INSERT INTO `historical_european` VALUES ('25', 'Bet365', '3.2', '3.4', '2.2', '3.3', '3.5', '2.15', '825919');
INSERT INTO `historical_european` VALUES ('26', '澳门', '2.75', '3.42', '2.23', '2.9', '3.4', '2.15', '825919');
INSERT INTO `historical_european` VALUES ('27', '皇冠', '2.93', '3.55', '2.19', '3.25', '3.35', '2.24', '825919');
INSERT INTO `historical_european` VALUES ('28', '威廉希尔', '2.9', '3.4', '2.3', '3.25', '3.2', '2.2', '825919');
INSERT INTO `historical_european` VALUES ('29', 'Bet365', '2.6', '3.4', '2.6', '2.05', '3.8', '3.25', '806813');
INSERT INTO `historical_european` VALUES ('30', '澳门', '2.27', '3.53', '2.62', '2.1', '3.53', '2.9', '806813');
INSERT INTO `historical_european` VALUES ('31', '皇冠', '2.45', '3.75', '2.48', '2.12', '3.8', '3.25', '806813');
INSERT INTO `historical_european` VALUES ('32', '威廉希尔', '2.5', '3.7', '2.62', '2.2', '3.8', '3.25', '806813');
INSERT INTO `historical_european` VALUES ('33', 'Bet365', '1.83', '3.5', '4.33', '1.95', '3.7', '4.1', '818441');
INSERT INTO `historical_european` VALUES ('34', '澳门', '1.88', '3.28', '3.73', '1.78', '3.35', '4.1', '818441');
INSERT INTO `historical_european` VALUES ('35', '皇冠', '1.85', '3.3', '3.9', '1.99', '3.35', '3.4', '818441');
INSERT INTO `historical_european` VALUES ('36', '威廉希尔', '1.83', '3.4', '4.5', '1.95', '3.5', '3.9', '818441');
INSERT INTO `historical_european` VALUES ('37', 'Bet365', '2.2', '3', '3.6', '2.4', '3.1', '3.1', '809791');
INSERT INTO `historical_european` VALUES ('38', '澳门', '2.2', '2.88', '3.28', '2.2', '2.88', '3.28', '809791');
INSERT INTO `historical_european` VALUES ('39', '皇冠', '2.23', '3.15', '3', '2.41', '2.93', '2.9', '809791');
INSERT INTO `historical_european` VALUES ('40', '威廉希尔', '2.25', '3', '3.5', '2.5', '3.2', '2.9', '809791');
INSERT INTO `historical_european` VALUES ('41', 'Bet365', '1.44', '4.2', '7.5', '1.28', '5.25', '11', '809795');
INSERT INTO `historical_european` VALUES ('42', '澳门', '1.41', '4.05', '6.8', '1.28', '4.6', '8.8', '809795');
INSERT INTO `historical_european` VALUES ('43', '皇冠', '1.47', '3.9', '6', '1.26', '5', '9.3', '809795');
INSERT INTO `historical_european` VALUES ('44', '威廉希尔', '1.44', '4', '8.5', '1.27', '5', '13', '809795');
INSERT INTO `historical_european` VALUES ('45', 'Bet365', '2.4', '3.4', '2.8', '2.15', '3.25', '3.6', '854154');
INSERT INTO `historical_european` VALUES ('46', '澳门', '2.33', '3.21', '2.73', '2.1', '3.2', '3.15', '854154');
INSERT INTO `historical_european` VALUES ('47', '皇冠', '2.38', '3.3', '2.79', '2.19', '3.25', '3.6', '854154');
INSERT INTO `historical_european` VALUES ('48', '威廉希尔', '2.45', '3.3', '2.88', '2.25', '3.2', '3.3', '854154');
INSERT INTO `historical_european` VALUES ('49', 'Bet365', '2.5', '3', '3', '2.4', '3.1', '3.2', '806801');
INSERT INTO `historical_european` VALUES ('50', '澳门', '2.48', '3.02', '2.68', '2.24', '3.2', '2.9', '806801');
INSERT INTO `historical_european` VALUES ('51', '皇冠', '2.4', '3.15', '2.89', '2.4', '3.1', '3.3', '806801');
INSERT INTO `historical_european` VALUES ('52', '威廉希尔', '2.4', '3.2', '3.1', '2.4', '3.1', '3.2', '806801');
INSERT INTO `historical_european` VALUES ('53', 'Bet365', '3.5', '3.6', '2', '3.9', '3.9', '1.85', '806803');
INSERT INTO `historical_european` VALUES ('54', '澳门', '3.48', '3.68', '1.83', '3.45', '3.6', '1.86', '806803');
INSERT INTO `historical_european` VALUES ('55', '皇冠', '3.4', '3.6', '1.95', '3.9', '3.65', '1.93', '806803');
INSERT INTO `historical_european` VALUES ('56', '威廉希尔', '3.75', '3.7', '1.95', '3.8', '3.75', '1.91', '806803');
INSERT INTO `historical_european` VALUES ('57', 'Bet365', '2.3', '3.25', '3.1', '2.1', '3.4', '3.5', '806805');
INSERT INTO `historical_european` VALUES ('58', '澳门', '2.17', '3.05', '3.15', '2.05', '3.05', '3.43', '806805');
INSERT INTO `historical_european` VALUES ('59', '皇冠', '2.28', '3.3', '2.95', '2.19', '3.35', '3.5', '806805');
INSERT INTO `historical_european` VALUES ('60', '威廉希尔', '2.3', '3.3', '3.25', '2.1', '3.4', '3.6', '806805');
INSERT INTO `historical_european` VALUES ('61', 'Bet365', '2.15', '3.5', '3.2', '2.37', '3.3', '3', '806807');
INSERT INTO `historical_european` VALUES ('62', '澳门', '2.15', '3.3', '2.95', '2.3', '3.1', '2.85', '806807');
INSERT INTO `historical_european` VALUES ('63', '皇冠', '2.21', '3.45', '2.95', '2.38', '3.3', '3.15', '806807');
INSERT INTO `historical_european` VALUES ('64', '威廉希尔', '2.2', '3.6', '3.2', '2.4', '3.25', '3.1', '806807');
INSERT INTO `historical_european` VALUES ('65', 'Bet365', '2.3', '3.5', '2.9', '2.45', '3.75', '2.62', '806819');
INSERT INTO `historical_european` VALUES ('66', '澳门', '2.25', '3.48', '2.67', '2.4', '3.35', '2.55', '806819');
INSERT INTO `historical_european` VALUES ('67', '皇冠', '2.26', '3.65', '2.76', '2.49', '3.65', '2.75', '806819');
INSERT INTO `historical_european` VALUES ('68', '威廉希尔', '2.3', '3.7', '2.9', '2.5', '3.7', '2.62', '806819');
INSERT INTO `historical_european` VALUES ('69', 'Bet365', '2.1', '3', '4', '2.25', '2.8', '3.75', '809803');
INSERT INTO `historical_european` VALUES ('70', '澳门', '2.11', '2.98', '3.38', '2.05', '2.98', '3.55', '809803');
INSERT INTO `historical_european` VALUES ('71', '皇冠', '2.19', '2.96', '3.25', '2.36', '2.75', '3.2', '809803');
INSERT INTO `historical_european` VALUES ('72', '威廉希尔', '2.1', '3.1', '3.9', '2.4', '2.7', '3.6', '809803');
INSERT INTO `historical_european` VALUES ('73', 'Bet365', '2.3', '3.4', '3', '2.35', '3.3', '3.4', '818443');
INSERT INTO `historical_european` VALUES ('74', '澳门', '2.18', '3.23', '2.97', '2.1', '3.23', '3.13', '818443');
INSERT INTO `historical_european` VALUES ('75', '皇冠', '2.25', '3.4', '2.75', '2.26', '3.15', '2.95', '818443');
INSERT INTO `historical_european` VALUES ('76', '威廉希尔', '2.35', '3.5', '2.9', '2.3', '3.2', '3.2', '818443');
INSERT INTO `historical_european` VALUES ('77', 'Bet365', '2.05', '3.4', '3.6', '2.1', '3.5', '3.75', '818445');
INSERT INTO `historical_european` VALUES ('78', '澳门', '2.15', '3.33', '2.92', '2.15', '3.33', '2.92', '818445');
INSERT INTO `historical_european` VALUES ('79', '皇冠', '2.07', '3.3', '3.15', '2.06', '3.35', '3.2', '818445');
INSERT INTO `historical_european` VALUES ('80', '威廉希尔', '2.05', '3.4', '3.6', '2.05', '3.4', '3.6', '818445');
INSERT INTO `historical_european` VALUES ('81', 'Bet365', '1.85', '3.9', '4.33', '2.05', '3.7', '3.75', '818447');
INSERT INTO `historical_european` VALUES ('82', '澳门', '1.83', '3.57', '3.57', '1.86', '3.45', '3.6', '818447');
INSERT INTO `historical_european` VALUES ('83', '皇冠', '1.9', '3.65', '3.35', '2.03', '3.5', '3.1', '818447');
INSERT INTO `historical_european` VALUES ('84', '威廉希尔', '1.83', '3.5', '3.75', '2', '3.6', '3.5', '818447');
INSERT INTO `historical_european` VALUES ('85', 'Bet365', '2.3', '3.3', '3.1', '1.95', '3.8', '4', '818449');
INSERT INTO `historical_european` VALUES ('86', '澳门', '2.1', '3.28', '3.08', '2.1', '3.28', '3.08', '818449');
INSERT INTO `historical_european` VALUES ('87', '皇冠', '2.21', '3.45', '2.8', '1.97', '3.4', '3.35', '818449');
INSERT INTO `historical_european` VALUES ('88', '威廉希尔', '2.3', '3.4', '3', '1.95', '3.6', '3.7', '818449');
INSERT INTO `historical_european` VALUES ('89', 'Bet365', '1.57', '3.75', '6', '1.6', '4.33', '6', '818451');
INSERT INTO `historical_european` VALUES ('90', '澳门', '1.53', '3.83', '5.3', '1.53', '3.83', '5.3', '818451');
INSERT INTO `historical_european` VALUES ('91', '皇冠', '1.59', '3.7', '5', '1.51', '4.05', '5.2', '818451');
INSERT INTO `historical_european` VALUES ('92', '威廉希尔', '1.62', '3.7', '5.8', '1.55', '4', '6', '818451');
INSERT INTO `historical_european` VALUES ('93', 'Bet365', '2', '3.4', '3.75', '2.05', '3.4', '4.1', '818453');
INSERT INTO `historical_european` VALUES ('94', '澳门', '1.93', '3.28', '3.53', '1.93', '3.28', '3.53', '818453');
INSERT INTO `historical_european` VALUES ('95', '皇冠', '2.04', '3.15', '3.45', '2.01', '3.2', '3.45', '818453');
INSERT INTO `historical_european` VALUES ('96', '威廉希尔', '2', '3.25', '3.9', '1.95', '3.3', '4.2', '818453');
INSERT INTO `historical_european` VALUES ('97', 'Bet365', '3', '3.4', '2.3', '3.6', '3.8', '2.05', '818455');
INSERT INTO `historical_european` VALUES ('98', '澳门', '2.71', '3.48', '2.23', '3.15', '3.5', '2', '818455');
INSERT INTO `historical_european` VALUES ('99', '皇冠', '2.78', '3.5', '2.2', '3.1', '3.45', '2.05', '818455');
INSERT INTO `historical_european` VALUES ('100', '威廉希尔', '2.9', '3.6', '2.3', '3.4', '3.6', '2.05', '818455');
INSERT INTO `historical_european` VALUES ('101', 'Bet365', '1.9', '3.5', '4', '2.25', '3.75', '3.2', '818457');
INSERT INTO `historical_european` VALUES ('102', '澳门', '2.12', '3.55', '2.85', '2.12', '3.55', '2.85', '818457');
INSERT INTO `historical_european` VALUES ('103', '皇冠', '1.97', '3.5', '3.25', '2.19', '3.5', '2.79', '818457');
INSERT INTO `historical_european` VALUES ('104', '威廉希尔', '1.95', '3.6', '3.7', '2.2', '3.5', '3.1', '818457');
INSERT INTO `historical_european` VALUES ('105', 'Bet365', '2.1', '3.4', '3.4', '2.35', '3.5', '3.2', '818459');
INSERT INTO `historical_european` VALUES ('106', '澳门', '2.18', '3.33', '2.88', '2.15', '3.25', '3', '818459');
INSERT INTO `historical_european` VALUES ('107', '皇冠', '2.13', '3.45', '2.94', '2.29', '3.4', '2.71', '818459');
INSERT INTO `historical_european` VALUES ('108', '威廉希尔', '2.15', '3.5', '3.2', '2.3', '3.3', '3.1', '818459');
INSERT INTO `historical_european` VALUES ('109', 'Bet365', '2.1', '3.3', '3.5', '2.05', '3.4', '4.1', '818461');
INSERT INTO `historical_european` VALUES ('110', '澳门', '2.08', '3.15', '3.25', '2.08', '3.15', '3.25', '818461');
INSERT INTO `historical_european` VALUES ('111', '皇冠', '2.16', '3.2', '3.1', '2.02', '3.15', '3.5', '818461');
INSERT INTO `historical_european` VALUES ('112', '威廉希尔', '2.15', '3.3', '3.4', '2.05', '3.25', '3.75', '818461');
INSERT INTO `historical_european` VALUES ('113', 'Bet365', '2.9', '3.3', '2.4', '3.3', '3.4', '2.15', '827561');
INSERT INTO `historical_european` VALUES ('114', '澳门', '3.18', '3.33', '2.03', '3.12', '3.33', '2.05', '827561');
INSERT INTO `historical_european` VALUES ('115', '皇冠', '3.1', '3.5', '2.27', '3.2', '3.55', '2.21', '827561');
INSERT INTO `historical_european` VALUES ('116', '威廉希尔', '2.8', '3.5', '2.35', '3.2', '3.4', '2.15', '827561');
INSERT INTO `historical_european` VALUES ('117', 'Bet365', '1.25', '5.75', '11', '1.44', '4.5', '7', '854152');
INSERT INTO `historical_european` VALUES ('118', '澳门', '1.25', '4.8', '9.9', '1.4', '4.1', '6.6', '854152');
INSERT INTO `historical_european` VALUES ('119', '皇冠', '1.25', '5.5', '9.7', '1.48', '4.4', '7', '854152');
INSERT INTO `historical_european` VALUES ('120', '威廉希尔', '1.22', '6', '13', '1.44', '4.33', '7.5', '854152');
INSERT INTO `historical_european` VALUES ('121', 'Bet365', '1.44', '5', '5.75', '1.36', '5.75', '7', '806811');
INSERT INTO `historical_european` VALUES ('122', '澳门', '1.32', '5', '6.7', '1.32', '5', '6.7', '806811');
INSERT INTO `historical_european` VALUES ('123', '皇冠', '1.46', '4.65', '5.5', '1.39', '5.5', '7', '806811');
INSERT INTO `historical_european` VALUES ('124', '威廉希尔', '1.47', '4.75', '6.5', '1.36', '5.5', '7.5', '806811');
INSERT INTO `historical_european` VALUES ('125', 'Bet365', '1.83', '4', '3.75', '1.95', '3.8', '3.5', '809107');
INSERT INTO `historical_european` VALUES ('126', '澳门', '1.68', '4.05', '3.8', '1.95', '3.38', '3.4', '809107');
INSERT INTO `historical_european` VALUES ('127', '皇冠', '1.87', '4.2', '3.6', '2.05', '3.7', '3.45', '809107');
INSERT INTO `historical_european` VALUES ('128', '威廉希尔', '1.78', '4', '3.9', '1.95', '3.7', '3.5', '809107');
INSERT INTO `historical_european` VALUES ('129', 'Bet365', '6.25', '4.2', '1.5', '5.75', '4.2', '1.53', '809109');
INSERT INTO `historical_european` VALUES ('130', '澳门', '5.2', '4.45', '1.45', '5.55', '4.7', '1.4', '809109');
INSERT INTO `historical_european` VALUES ('131', '皇冠', '4.55', '4.4', '1.66', '5', '4.5', '1.6', '809109');
INSERT INTO `historical_european` VALUES ('132', '威廉希尔', '4.8', '4.33', '1.6', '5.25', '4.33', '1.53', '809109');
INSERT INTO `historical_european` VALUES ('133', 'Bet365', '1.18', '8.5', '10', '1.28', '5.75', '8.5', '809111');
INSERT INTO `historical_european` VALUES ('134', '澳门', '1.17', '6.7', '10', '1.22', '5.5', '9.8', '809111');
INSERT INTO `historical_european` VALUES ('135', '皇冠', '1.23', '6.9', '10.5', '1.28', '6.1', '9.2', '809111');
INSERT INTO `historical_european` VALUES ('136', '威廉希尔', '1.2', '6.5', '13', '1.24', '5.8', '11', '809111');
INSERT INTO `historical_european` VALUES ('137', 'Bet365', '2.75', '3.5', '2.4', '2.8', '3.8', '2.25', '827553');
INSERT INTO `historical_european` VALUES ('138', '澳门', '2.65', '3.61', '2.22', '2.6', '3.61', '2.26', '827553');
INSERT INTO `historical_european` VALUES ('139', '皇冠', '2.77', '3.85', '2.33', '2.78', '3.8', '2.34', '827553');
INSERT INTO `historical_european` VALUES ('140', '威廉希尔', '2.7', '3.6', '2.35', '2.7', '3.7', '2.35', '827553');
INSERT INTO `historical_european` VALUES ('141', 'Bet365', '2.37', '3.3', '2.9', '2.37', '3.5', '2.9', '827555');
INSERT INTO `historical_european` VALUES ('142', '澳门', '2.33', '3.32', '2.65', '2.25', '3.3', '2.8', '827555');
INSERT INTO `historical_european` VALUES ('143', '皇冠', '2.41', '3.45', '2.89', '2.38', '3.35', '3.05', '827555');
INSERT INTO `historical_european` VALUES ('144', '威廉希尔', '2.35', '3.4', '2.88', '2.35', '3.3', '2.9', '827555');
INSERT INTO `historical_european` VALUES ('145', 'Bet365', '6', '4.33', '1.5', '5', '4.5', '1.57', '827565');
INSERT INTO `historical_european` VALUES ('146', '澳门', '5.6', '4.4', '1.43', '4.8', '4.2', '1.45', '827565');
INSERT INTO `historical_european` VALUES ('147', '皇冠', '5.3', '4.6', '1.55', '5.4', '4.15', '1.6', '827565');
INSERT INTO `historical_european` VALUES ('148', '威廉希尔', '5.5', '4.4', '1.52', '5.5', '4', '1.57', '827565');
INSERT INTO `historical_european` VALUES ('149', 'Bet365', '1.44', '4.75', '6', '1.44', '4.75', '6', '809113');
INSERT INTO `historical_european` VALUES ('150', '澳门', '1.41', '4.6', '5.6', '1.41', '4.6', '5.6', '809113');
INSERT INTO `historical_european` VALUES ('151', '皇冠', '1.5', '4.8', '5.7', '1.47', '4.8', '6.1', '809113');
INSERT INTO `historical_european` VALUES ('152', '威廉希尔', '1.44', '4.6', '6', '1.44', '4.6', '6', '809113');
INSERT INTO `historical_european` VALUES ('153', 'Bet365', '1.7', '3.5', '5.25', '1.6', '3.75', '6', '854146');
INSERT INTO `historical_european` VALUES ('154', '澳门', '1.7', '3.3', '4.65', '1.6', '3.6', '4.9', '854146');
INSERT INTO `historical_european` VALUES ('155', '皇冠', '1.7', '3.7', '4.5', '1.65', '3.75', '5.9', '854146');
INSERT INTO `historical_european` VALUES ('156', '威廉希尔', '1.7', '3.5', '5.25', '1.62', '3.7', '5.8', '854146');

-- ----------------------------
-- Table structure for `historical_history`
-- ----------------------------
DROP TABLE IF EXISTS `historical_history`;
CREATE TABLE `historical_history` (
  `matchId` int(11) NOT NULL,
  `match` varchar(10) NOT NULL,
  `round` varchar(10) NOT NULL,
  `time` date NOT NULL,
  `match_time` varchar(16) NOT NULL,
  `hostTeam` varchar(16) NOT NULL,
  `guestTeam` varchar(16) NOT NULL,
  `result` varchar(5) NOT NULL,
  PRIMARY KEY (`matchId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of historical_history
-- ----------------------------
INSERT INTO `historical_history` VALUES ('806801', '英超', '第18轮', '2019-12-21', '2019-12-21 23:00', '纽卡斯尔联', '水晶宫', '1:0');
INSERT INTO `historical_history` VALUES ('806803', '英超', '第18轮', '2019-12-21', '2019-12-21 23:00', '诺维奇', '狼队', '1:2');
INSERT INTO `historical_history` VALUES ('806805', '英超', '第18轮', '2019-12-21', '2019-12-21 23:00', '布赖顿', '谢菲尔德联', '0:1');
INSERT INTO `historical_history` VALUES ('806807', '英超', '第18轮', '2019-12-21', '2019-12-21 23:00', '伯恩茅斯', '伯恩利', '0:1');
INSERT INTO `historical_history` VALUES ('806811', '英超', '第18轮', '2019-12-21', '2019-12-22 01:30', '曼彻斯特城', '莱切斯特城', '3:1');
INSERT INTO `historical_history` VALUES ('806813', '英超', '第18轮', '2019-12-21', '2019-12-21 20:30', '埃弗顿', '阿森纳', '0:0');
INSERT INTO `historical_history` VALUES ('806819', '英超', '第18轮', '2019-12-21', '2019-12-21 23:00', '阿斯顿维拉', '南安普敦', '1:3');
INSERT INTO `historical_history` VALUES ('809107', '荷甲', '第18轮', '2019-12-21', '2019-12-22 01:30', '海伦芬', '赫拉克勒斯', '1:1');
INSERT INTO `historical_history` VALUES ('809109', '荷甲', '第18轮', '2019-12-21', '2019-12-22 02:45', '鹿特丹斯巴达', '阿尔克马尔', '3:0');
INSERT INTO `historical_history` VALUES ('809111', '荷甲', '第18轮', '2019-12-21', '2019-12-22 02:45', 'PSV埃因霍温', '兹沃勒', '4:1');
INSERT INTO `historical_history` VALUES ('809113', '荷甲', '第18轮', '2019-12-21', '2019-12-22 03:45', '威廉二世', '福图纳锡塔德', '0:0');
INSERT INTO `historical_history` VALUES ('809791', '法乙', '第19轮', '2019-12-21', '2019-12-21 22:00', '巴黎FC', '勒芒', '0:3');
INSERT INTO `historical_history` VALUES ('809795', '法乙', '第19轮', '2019-12-21', '2019-12-21 22:00', '朗斯', '尼奥尔', '1:0');
INSERT INTO `historical_history` VALUES ('809803', '法乙', '第19轮', '2019-12-21', '2019-12-21 23:00', '特鲁瓦', '阿雅克肖', '2:1');
INSERT INTO `historical_history` VALUES ('818441', '英甲', '第22轮', '2019-12-21', '2019-12-21 21:00', '吉灵汉姆', '米尔顿凯恩斯', '3:1');
INSERT INTO `historical_history` VALUES ('818443', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '朴茨茅斯', '伊普斯维奇', '1:0');
INSERT INTO `historical_history` VALUES ('818445', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '牛津联', '韦康比流浪者', '1:0');
INSERT INTO `historical_history` VALUES ('818447', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '博尔顿', '南安联', '3:2');
INSERT INTO `historical_history` VALUES ('818449', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '特兰米尔', 'AFC温布尔登', '1:0');
INSERT INTO `historical_history` VALUES ('818451', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '伯顿', '罗奇代尔', '3:1');
INSERT INTO `historical_history` VALUES ('818453', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '考文垂', '林肯城', '1:0');
INSERT INTO `historical_history` VALUES ('818455', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '布里斯托尔流浪', '彼得堡联', '0:0');
INSERT INTO `historical_history` VALUES ('818457', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '唐卡斯特', '阿克宁顿', '1:1');
INSERT INTO `historical_history` VALUES ('818459', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '罗瑟汉姆', '福利特伍德', '2:2');
INSERT INTO `historical_history` VALUES ('818461', '英甲', '第22轮', '2019-12-21', '2019-12-21 23:00', '布莱克浦', '什鲁斯伯里', '0:1');
INSERT INTO `historical_history` VALUES ('825903', '德乙', '第18轮', '2019-12-21', '2019-12-21 20:00', '奥厄', '菲尔特', '3:1');
INSERT INTO `historical_history` VALUES ('825907', '德乙', '第18轮', '2019-12-21', '2019-12-21 20:00', '达姆施塔特', '汉堡', '2:2');
INSERT INTO `historical_history` VALUES ('825909', '德乙', '第18轮', '2019-12-21', '2019-12-21 20:00', '汉诺威96', '斯图加特', '2:2');
INSERT INTO `historical_history` VALUES ('825919', '德乙', '第18轮', '2019-12-21', '2019-12-21 20:00', '圣保利', '比勒费尔德', '3:0');
INSERT INTO `historical_history` VALUES ('827553', '比甲', '第20轮', '2019-12-21', '2019-12-22 03:00', '色格拉布鲁日', '聚尔特瓦雷赫姆', '2:0');
INSERT INTO `historical_history` VALUES ('827555', '比甲', '第20轮', '2019-12-21', '2019-12-22 03:00', '欧本', '科特赖克', '1:2');
INSERT INTO `historical_history` VALUES ('827561', '比甲', '第20轮', '2019-12-21', '2019-12-22 01:00', '摩斯高伦', '沙勒罗瓦', '1:1');
INSERT INTO `historical_history` VALUES ('827565', '比甲', '第20轮', '2019-12-21', '2019-12-22 03:30', '贝弗伦', '标准列日', '2:1');
INSERT INTO `historical_history` VALUES ('854146', '意甲', '第17轮', '2019-12-21', '2019-12-22 03:45', '都灵', '费拉拉SPAL', '1:2');
INSERT INTO `historical_history` VALUES ('854152', '意甲', '第17轮', '2019-12-21', '2019-12-22 01:00', '国际米兰', '热那亚', '4:0');
INSERT INTO `historical_history` VALUES ('854154', '意甲', '第17轮', '2019-12-21', '2019-12-21 22:00', '乌迪内斯', '卡利亚里', '2:1');
INSERT INTO `historical_history` VALUES ('869882', '澳超', '第11轮', '2019-12-21', '2019-12-21 14:00', '墨尔本城', '墨尔本胜利', '1:2');
INSERT INTO `historical_history` VALUES ('869884', '澳超', '第11轮', '2019-12-21', '2019-12-21 11:45', '惠灵顿凤凰', '悉尼FC', '2:2');
INSERT INTO `historical_history` VALUES ('869886', '澳超', '第11轮', '2019-12-21', '2019-12-21 16:30', '珀斯光荣', '纽卡斯尔喷气机', '6:2');
