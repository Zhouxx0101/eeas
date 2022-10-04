/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : eeas

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 03/10/2022 16:37:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for eeas_event
-- ----------------------------
DROP TABLE IF EXISTS `eeas_event`;
CREATE TABLE `eeas_event`  (
  `id` bigint(0) NOT NULL COMMENT '事件id',
  `time` datetime(0) NULL DEFAULT NULL COMMENT '时间',
  `place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '场所',
  `event` tinyint(0) NULL DEFAULT NULL COMMENT '事件，一一枚举',
  `source` bigint(0) NULL DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `source`(`source`) USING BTREE,
  CONSTRAINT `eeas_event_ibfk_1` FOREIGN KEY (`source`) REFERENCES `eeas_news` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '事件数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eeas_event
-- ----------------------------
INSERT INTO `eeas_event` VALUES (1576128700527951874, '2022-10-01 00:00:00', '1', 1, 1576117076773695489);
INSERT INTO `eeas_event` VALUES (1576128942023393282, '2022-10-01 00:00:00', '2', 2, 1576117076773695489);
INSERT INTO `eeas_event` VALUES (1576129835603083266, '2022-10-01 00:00:00', '3', 3, 1576117076773695489);
INSERT INTO `eeas_event` VALUES (1576132565591670785, '2022-09-30 00:00:00', '4-1', 11, 1576119416645873666);

-- ----------------------------
-- Table structure for eeas_news
-- ----------------------------
DROP TABLE IF EXISTS `eeas_news`;
CREATE TABLE `eeas_news`  (
  `id` bigint(0) NOT NULL COMMENT '新闻id',
  `type` tinyint(0) NULL DEFAULT NULL COMMENT '新闻类型：0、区域时空行为新闻 1、患者个人信息新闻 2、患者时空行为新闻 3、区域病例数据新闻 4、其他',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新闻标题',
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新闻链接',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '新闻全文',
  `time` datetime(0) NULL DEFAULT NULL COMMENT '新闻日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '新闻数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eeas_news
-- ----------------------------
INSERT INTO `eeas_news` VALUES (1576117076773695489, 0, '1', '1', '<p>1</p>', NULL);
INSERT INTO `eeas_news` VALUES (1576119416645873666, 1, '2', '2', '<p>2</p>', NULL);
INSERT INTO `eeas_news` VALUES (1576123515038699521, 3, '4', '4', '<p>4-1</p>', NULL);

-- ----------------------------
-- Table structure for eeas_number_change
-- ----------------------------
DROP TABLE IF EXISTS `eeas_number_change`;
CREATE TABLE `eeas_number_change`  (
  `id` bigint(0) NOT NULL COMMENT 'id',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '起始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `increase` int(0) NULL DEFAULT NULL COMMENT '新增数',
  `diagnosis` int(0) NULL DEFAULT NULL COMMENT '确诊数',
  `close_contact` int(0) NULL DEFAULT NULL COMMENT '密切接触者人数',
  `medical_observation` int(0) NULL DEFAULT NULL COMMENT '正在接受医学观察人数',
  `source` bigint(0) NULL DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `source`(`source`) USING BTREE,
  CONSTRAINT `eeas_number_change_ibfk_1` FOREIGN KEY (`source`) REFERENCES `eeas_news` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '病例变化数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eeas_number_change
-- ----------------------------
INSERT INTO `eeas_number_change` VALUES (1576129754766262274, '2022-10-01 00:00:00', '2022-10-01 00:00:00', 1, 1, 1, 1, 1576117076773695489);

-- ----------------------------
-- Table structure for eeas_patient
-- ----------------------------
DROP TABLE IF EXISTS `eeas_patient`;
CREATE TABLE `eeas_patient`  (
  `id` bigint(0) NOT NULL COMMENT '患者id',
  `sex` tinyint(0) NULL DEFAULT NULL COMMENT '性别，0、男 1、女 2、其他',
  `age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  `occupation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职业',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `type` tinyint(0) NULL DEFAULT NULL COMMENT '分型，0、无症状感染者 1、轻型 2、普通型 3、重型 4、其他',
  `source1` bigint(0) NULL DEFAULT NULL COMMENT '来源1',
  `source2` bigint(0) NULL DEFAULT NULL COMMENT '来源2',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `source1`(`source1`) USING BTREE,
  INDEX `source2`(`source2`) USING BTREE,
  CONSTRAINT `eeas_patient_ibfk_1` FOREIGN KEY (`source1`) REFERENCES `eeas_news` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `eeas_patient_ibfk_2` FOREIGN KEY (`source2`) REFERENCES `eeas_news` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '患者数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eeas_patient
-- ----------------------------
INSERT INTO `eeas_patient` VALUES (1576129319481393153, 0, 10, '1', '1', 0, NULL, NULL);
INSERT INTO `eeas_patient` VALUES (1576129399634542594, 1, 11, '2', '2', 1, 1576117076773695489, 1576117076773695489);

-- ----------------------------
-- Table structure for eeas_trajectory
-- ----------------------------
DROP TABLE IF EXISTS `eeas_trajectory`;
CREATE TABLE `eeas_trajectory`  (
  `id` bigint(0) NOT NULL COMMENT '轨迹id',
  `pid` bigint(0) NULL DEFAULT NULL COMMENT '患者id',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '起始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '场所',
  `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  `risk_level` tinyint(0) NULL DEFAULT NULL COMMENT '风险等级',
  `raw_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '原始文本',
  `source` bigint(0) NULL DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `source`(`source`) USING BTREE,
  CONSTRAINT `eeas_trajectory_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `eeas_patient` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `eeas_trajectory_ibfk_2` FOREIGN KEY (`source`) REFERENCES `eeas_news` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '轨迹数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eeas_trajectory
-- ----------------------------
INSERT INTO `eeas_trajectory` VALUES (1576129610008248322, 1576129319481393153, '2022-10-01 00:00:00', '2022-10-01 00:00:00', '1', NULL, NULL, NULL, '1', 1576117076773695489);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'eeas_event', '事件数据', NULL, NULL, 'Event', 'crud', 'com.ruoyi.eeas', 'data', 'event', '事件数据', 'zhouxinxing', '0', '/', '{\"parentMenuId\":\"2003\"}', 'admin', '2022-09-29 15:12:32', '', '2022-10-01 16:49:29', NULL);
INSERT INTO `gen_table` VALUES (2, 'eeas_news', '新闻数据', NULL, NULL, 'News', 'crud', 'com.ruoyi.eeas', 'data', 'news', '新闻数据', 'zhouxinxing', '0', '/', '{\"parentMenuId\":\"2003\"}', 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:24', NULL);
INSERT INTO `gen_table` VALUES (3, 'eeas_number_change', '病例变化数据', NULL, NULL, 'NumberChange', 'crud', 'com.ruoyi.eeas', 'data', 'change', '病例变化数据', 'zhouxinxing', '0', '/', '{\"parentMenuId\":2003}', 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29', NULL);
INSERT INTO `gen_table` VALUES (4, 'eeas_patient', '患者数据', NULL, NULL, 'Patient', 'crud', 'com.ruoyi.eeas', 'data', 'patient', '患者数据', 'zhouxinxing', '0', '/', '{\"parentMenuId\":\"2003\"}', 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47', NULL);
INSERT INTO `gen_table` VALUES (5, 'eeas_trajectory', '轨迹数据', NULL, NULL, 'Trajectory', 'crud', 'com.ruoyi.eeas', 'data', 'trajectory', '轨迹数据', 'zhouxinxing', '0', '/', '{\"parentMenuId\":2003}', 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'id', '事件id', 'bigint', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-09-29 15:12:32', '', '2022-10-01 16:49:29');
INSERT INTO `gen_table_column` VALUES (2, '1', 'time', '时间', 'datetime', 'Date', 'time', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 2, 'admin', '2022-09-29 15:12:32', '', '2022-10-01 16:49:29');
INSERT INTO `gen_table_column` VALUES (3, '1', 'place', '场所', 'varchar(255)', 'String', 'place', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-09-29 15:12:32', '', '2022-10-01 16:49:29');
INSERT INTO `gen_table_column` VALUES (4, '1', 'event', '事件，一一枚举', 'tinyint', 'Long', 'event', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'eeas_event', 4, 'admin', '2022-09-29 15:12:32', '', '2022-10-01 16:49:29');
INSERT INTO `gen_table_column` VALUES (5, '1', 'source', '来源', 'bigint', 'Long', 'source', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-09-29 15:12:32', '', '2022-10-01 16:49:29');
INSERT INTO `gen_table_column` VALUES (6, '2', 'id', '新闻id', 'bigint', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:24');
INSERT INTO `gen_table_column` VALUES (7, '2', 'type', '新闻类型：1、区域时空行为新闻 2、患者个人信息新闻 3、患者时空行为新闻 4、区域病例数据新闻 5、其他', 'tinyint', 'Long', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'eeas_news', 2, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:25');
INSERT INTO `gen_table_column` VALUES (8, '2', 'title', '新闻标题', 'varchar(255)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:25');
INSERT INTO `gen_table_column` VALUES (9, '2', 'link', '新闻链接', 'varchar(255)', 'String', 'link', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:25');
INSERT INTO `gen_table_column` VALUES (10, '2', 'content', '新闻全文', 'text', 'String', 'content', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'editor', '', 5, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:25');
INSERT INTO `gen_table_column` VALUES (11, '3', 'id', 'id', 'bigint', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29');
INSERT INTO `gen_table_column` VALUES (12, '3', 'start_time', '起始时间', 'datetime', 'Date', 'startTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 2, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29');
INSERT INTO `gen_table_column` VALUES (13, '3', 'end_time', '结束时间', 'datetime', 'Date', 'endTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29');
INSERT INTO `gen_table_column` VALUES (14, '3', 'increase', '新增数', 'int', 'Long', 'increase', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29');
INSERT INTO `gen_table_column` VALUES (15, '3', 'diagnosis', '确诊数', 'int', 'Long', 'diagnosis', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29');
INSERT INTO `gen_table_column` VALUES (16, '3', 'close_contact', '密切接触者人数', 'int', 'Long', 'closeContact', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29');
INSERT INTO `gen_table_column` VALUES (17, '3', 'medical_observation', '正在接受医学观察人数', 'int', 'Long', 'medicalObservation', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29');
INSERT INTO `gen_table_column` VALUES (18, '3', 'source', '来源', 'bigint', 'Long', 'source', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:22:29');
INSERT INTO `gen_table_column` VALUES (19, '4', 'id', '患者id', 'bigint', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47');
INSERT INTO `gen_table_column` VALUES (20, '4', 'sex', '性别，1、男 2、女 3、其他', 'tinyint', 'Long', 'sex', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'sys_user_sex', 2, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47');
INSERT INTO `gen_table_column` VALUES (21, '4', 'age', '年龄', 'int', 'Long', 'age', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47');
INSERT INTO `gen_table_column` VALUES (22, '4', 'occupation', '职业', 'varchar(255)', 'String', 'occupation', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47');
INSERT INTO `gen_table_column` VALUES (23, '4', 'address', '家庭住址', 'varchar(255)', 'String', 'address', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47');
INSERT INTO `gen_table_column` VALUES (24, '4', 'type', '分型，1、无症状感染者 2、轻型 3、普通型 4、重型', 'tinyint', 'Long', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'eeas_patient', 6, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47');
INSERT INTO `gen_table_column` VALUES (25, '4', 'source1', '来源1', 'bigint', 'Long', 'source1', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47');
INSERT INTO `gen_table_column` VALUES (26, '4', 'source2', '来源2', 'bigint', 'Long', 'source2', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2022-09-29 15:12:32', '', '2022-09-30 17:52:47');
INSERT INTO `gen_table_column` VALUES (27, '5', 'id', '轨迹id', 'bigint', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (28, '5', 'pid', '患者id', 'bigint', 'Long', 'pid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (29, '5', 'start_time', '起始时间', 'datetime', 'Date', 'startTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (30, '5', 'end_time', '结束时间', 'datetime', 'Date', 'endTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (31, '5', 'place', '场所', 'varchar(255)', 'String', 'place', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (32, '5', 'longitude', '经度', 'varchar(255)', 'String', 'longitude', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (33, '5', 'latitude', '纬度', 'varchar(255)', 'String', 'latitude', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (34, '5', 'risk_level', '风险等级', 'tinyint', 'Long', 'riskLevel', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (35, '5', 'raw_text', '原始文本', 'text', 'String', 'rawText', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 9, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');
INSERT INTO `gen_table_column` VALUES (36, '5', 'source', '来源', 'bigint', 'Long', 'source', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2022-09-29 15:12:32', '', '2022-09-29 17:19:41');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(0) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(0) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(0) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(0) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(0) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(0) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(0) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(0) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(0) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(0) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(0) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(0) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(0) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(0) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(0) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(0) NOT NULL COMMENT '开始时间',
  `end_time` bigint(0) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(0) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-09-17 12:49:24', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-09-17 12:49:24', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-09-17 12:49:24', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2022-09-17 12:49:24', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-09-17 12:49:24', '', NULL, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:03', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-17 12:49:04', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(0) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-09-17 12:49:23', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '区域时空行为新闻', '0', 'eeas_news', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:36:14', 'admin', '2022-09-30 17:36:25', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 2, '患者个人信息新闻 ', '1', 'eeas_news', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:36:58', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 3, '患者时空行为新闻', '2', 'eeas_news', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:37:10', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 4, '区域病例数据新闻', '3', 'eeas_news', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:37:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 5, '其他', '4', 'eeas_news', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:37:39', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 1, '划定封控区', '0', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:40:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 2, '只出不进', '1', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:40:38', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 3, '停运', '2', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:40:55', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (108, 4, '区间运营', '3', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:41:07', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (109, 5, '关闭', '4', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:41:30', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 6, '划定高风险地区', '5', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:41:43', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (111, 7, '划定中风险地区', '6', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:41:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (112, 8, '划定管控区', '7', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:42:25', 'admin', '2022-09-30 17:42:48', NULL);
INSERT INTO `sys_dict_data` VALUES (113, 9, '划定防范区', '8', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:42:35', 'admin', '2022-09-30 17:42:53', NULL);
INSERT INTO `sys_dict_data` VALUES (114, 10, '全封闭管理', '9', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:43:27', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (115, 11, '暂停对外开放', '10', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:43:45', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (116, 12, '解除封控区管控', '11', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:44:30', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (117, 13, '恢复运营', '12', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:44:51', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (118, 14, '恢复部分运营', '13', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:45:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (119, 15, '恢复营业', '14', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:45:35', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (120, 16, '开放', '15', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:45:47', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (121, 17, '划定低风险地区', '16', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:46:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (122, 18, '解除管控区管控', '17', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:46:55', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (123, 19, '解除防范区管控', '18', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:47:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (124, 20, '开启', '19', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:48:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (125, 21, '开站', '20', 'eeas_event', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:48:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (126, 1, '无症状感染者', '0', 'eeas_patient', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:49:51', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (127, 2, '轻型', '1', 'eeas_patient', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:50:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (128, 3, '普通型', '2', 'eeas_patient', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:50:11', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (129, 4, '重型', '3', 'eeas_patient', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:50:23', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (130, 5, '其他', '4', 'eeas_patient', NULL, 'default', 'N', '0', 'admin', '2022-09-30 17:50:45', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-09-17 12:49:22', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '新闻类型', 'eeas_news', '0', 'admin', '2022-09-30 17:31:50', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (101, '事件', 'eeas_event', '0', 'admin', '2022-09-30 17:39:59', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '分型', 'eeas_patient', '0', 'admin', '2022-09-30 17:49:36', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-09-17 12:49:31', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-09-17 12:49:31', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-09-17 12:49:31', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-17 13:28:23');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-17 13:32:00');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-17 14:50:12');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-17 15:21:59');
INSERT INTO `sys_logininfor` VALUES (104, 'ry', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-17 16:31:09');
INSERT INTO `sys_logininfor` VALUES (105, 'ry', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-09-17 16:52:15');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-17 16:52:21');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-26 11:03:46');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-09-26 20:55:02');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-26 20:55:06');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-27 17:00:22');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-27 17:39:08');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-27 18:47:43');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-09-27 19:28:25');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-27 19:28:29');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-27 20:59:27');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-09-29 14:57:45');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-29 14:57:49');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-09-29 15:45:19');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-29 15:45:24');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-29 16:45:07');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-29 18:30:59');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-30 15:59:57');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-30 17:25:59');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-09-30 18:59:30');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-01 15:03:07');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-01 17:29:05');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-01 18:09:20');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-02 09:25:51');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-02 10:34:37');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-02 11:10:34');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(0) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(0) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2034 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-09-17 12:49:13', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-09-17 12:49:13', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-09-17 12:49:13', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-09-17 12:49:13', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-09-17 12:49:13', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-09-17 12:49:13', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-09-17 12:49:13', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-09-17 12:49:13', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-09-17 12:49:13', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-09-17 12:49:13', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-09-17 12:49:13', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-09-17 12:49:13', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-09-17 12:49:13', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-09-17 12:49:13', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-09-17 12:49:13', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-09-17 12:49:13', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-09-17 12:49:13', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-09-17 12:49:13', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-09-17 12:49:13', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-09-17 12:49:13', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-09-17 12:49:13', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-09-17 12:49:13', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-09-17 12:49:13', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-09-17 12:49:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '分布地图', 0, 4, 'map', 'map/index', NULL, 1, 0, 'C', '0', '0', '', 'international', 'admin', '2022-09-26 11:08:52', 'admin', '2022-09-26 11:09:45', '');
INSERT INTO `sys_menu` VALUES (2001, '风险区域', 0, 5, 'area', 'area/index', NULL, 1, 0, 'C', '0', '0', '', 'online', 'admin', '2022-09-26 21:08:24', 'admin', '2022-09-26 21:08:32', '');
INSERT INTO `sys_menu` VALUES (2002, '病例演化', 0, 6, 'evolution', 'evolution/index', NULL, 1, 0, 'C', '0', '0', NULL, 'chart', 'admin', '2022-09-26 21:11:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '数据采集', 0, 7, 'data', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'clipboard', 'admin', '2022-09-29 14:59:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '新闻数据', 2003, 1, 'news', 'data/news/index', NULL, 1, 0, 'C', '0', '0', 'data:news:list', '#', 'admin', '2022-09-29 15:44:50', '', NULL, '新闻数据菜单');
INSERT INTO `sys_menu` VALUES (2005, '新闻数据查询', 2004, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:news:query', '#', 'admin', '2022-09-29 15:44:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '新闻数据新增', 2004, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:news:add', '#', 'admin', '2022-09-29 15:44:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '新闻数据修改', 2004, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:news:edit', '#', 'admin', '2022-09-29 15:44:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '新闻数据删除', 2004, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:news:remove', '#', 'admin', '2022-09-29 15:44:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '新闻数据导出', 2004, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:news:export', '#', 'admin', '2022-09-29 15:44:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '事件数据', 2003, 2, 'event', 'data/event/index', NULL, 1, 0, 'C', '0', '0', 'data:event:list', '#', 'admin', '2022-09-29 15:46:05', '', NULL, '事件数据菜单');
INSERT INTO `sys_menu` VALUES (2011, '事件数据查询', 2010, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:event:query', '#', 'admin', '2022-09-29 15:46:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '事件数据新增', 2010, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:event:add', '#', 'admin', '2022-09-29 15:46:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '事件数据修改', 2010, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:event:edit', '#', 'admin', '2022-09-29 15:46:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '事件数据删除', 2010, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:event:remove', '#', 'admin', '2022-09-29 15:46:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '事件数据导出', 2010, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:event:export', '#', 'admin', '2022-09-29 15:46:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '病例变化数据', 2003, 5, 'change', 'data/change/index', NULL, 1, 0, 'C', '0', '0', 'data:change:list', '#', 'admin', '2022-09-29 15:47:36', '', NULL, '病例变化数据菜单');
INSERT INTO `sys_menu` VALUES (2017, '病例变化数据查询', 2016, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:change:query', '#', 'admin', '2022-09-29 15:47:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '病例变化数据新增', 2016, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:change:add', '#', 'admin', '2022-09-29 15:47:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '病例变化数据修改', 2016, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:change:edit', '#', 'admin', '2022-09-29 15:47:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '病例变化数据删除', 2016, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:change:remove', '#', 'admin', '2022-09-29 15:47:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '病例变化数据导出', 2016, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:change:export', '#', 'admin', '2022-09-29 15:47:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '患者数据', 2003, 3, 'patient', 'data/patient/index', NULL, 1, 0, 'C', '0', '0', 'data:patient:list', '#', 'admin', '2022-09-29 15:48:18', '', NULL, '患者数据菜单');
INSERT INTO `sys_menu` VALUES (2023, '患者数据查询', 2022, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:patient:query', '#', 'admin', '2022-09-29 15:48:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '患者数据新增', 2022, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:patient:add', '#', 'admin', '2022-09-29 15:48:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '患者数据修改', 2022, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:patient:edit', '#', 'admin', '2022-09-29 15:48:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '患者数据删除', 2022, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:patient:remove', '#', 'admin', '2022-09-29 15:48:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '患者数据导出', 2022, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:patient:export', '#', 'admin', '2022-09-29 15:48:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '轨迹数据', 2003, 4, 'trajectory', 'data/trajectory/index', NULL, 1, 0, 'C', '0', '0', 'data:trajectory:list', '#', 'admin', '2022-09-29 15:49:02', '', NULL, '轨迹数据菜单');
INSERT INTO `sys_menu` VALUES (2029, '轨迹数据查询', 2028, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:trajectory:query', '#', 'admin', '2022-09-29 15:49:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '轨迹数据新增', 2028, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:trajectory:add', '#', 'admin', '2022-09-29 15:49:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '轨迹数据修改', 2028, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:trajectory:edit', '#', 'admin', '2022-09-29 15:49:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '轨迹数据删除', 2028, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:trajectory:remove', '#', 'admin', '2022-09-29 15:49:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '轨迹数据导出', 2028, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'data:trajectory:export', '#', 'admin', '2022-09-29 15:49:02', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-09-17 12:49:35', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-09-17 12:49:35', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(0) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(0) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(0) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 205 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"分布地图\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"/map\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-26 11:08:53');
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-09-26 11:08:52\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"分布地图\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"/map\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-26 11:09:02');
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-09-26 11:08:52\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"分布地图\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"map\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-26 11:09:31');
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-09-26 11:08:52\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"分布地图\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"map\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-26 11:09:45');
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"area\\\\index\",\"createBy\":\"admin\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"风险区域\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"area\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-26 21:08:24');
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"area/index\",\"createTime\":\"2022-09-26 21:08:24\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"风险区域\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"area\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-26 21:08:32');
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"evolution/index\",\"createBy\":\"admin\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"病例演化\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"evolution\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-26 21:11:15');
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"数据采集\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"data\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 14:59:51');
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '\"eeas_number_change,eeas_trajectory,eeas_patient,eeas_event,eeas_news\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 15:12:32');
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 15:12:48');
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 15:12:51');
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 15:12:52');
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 15:12:52');
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 15:12:53');
INSERT INTO `sys_oper_log` VALUES (114, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"news\",\"className\":\"News\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"新闻id\",\"columnId\":6,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Type\",\"columnComment\":\"新闻类型：1、区域时空行为新闻 2、患者个人信息新闻 3、患者时空行为新闻 4、区域病例数据新闻 5、其他\",\"columnId\":7,\"columnName\":\"type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"type\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"新闻标题\",\"columnId\":8,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Link\",\"columnComment\":\"新闻链接\",\"columnId\":9,\"columnName\":\"link\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"link\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":fal', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 16:50:33');
INSERT INTO `sys_oper_log` VALUES (115, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 16:50:38');
INSERT INTO `sys_oper_log` VALUES (116, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"news\",\"className\":\"News\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"新闻id\",\"columnId\":6,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:50:33\",\"usableColumn\":false},{\"capJavaField\":\"Type\",\"columnComment\":\"新闻类型：1、区域时空行为新闻 2、患者个人信息新闻 3、患者时空行为新闻 4、区域病例数据新闻 5、其他\",\"columnId\":7,\"columnName\":\"type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"type\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:50:33\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"新闻标题\",\"columnId\":8,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:50:33\",\"usableColumn\":false},{\"capJavaField\":\"Link\",\"columnComment\":\"新闻链接\",\"columnId\":9,\"columnName\":\"link\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isL', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 16:54:15');
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 16:54:17');
INSERT INTO `sys_oper_log` VALUES (118, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"event\",\"className\":\"Event\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"事件id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Time\",\"columnComment\":\"时间\",\"columnId\":2,\"columnName\":\"time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"time\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Place\",\"columnComment\":\"场所\",\"columnId\":3,\"columnName\":\"place\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"place\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Event\",\"columnComment\":\"事件，一一枚举\",\"columnId\":4,\"columnName\":\"event\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"event\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 16:57:22');
INSERT INTO `sys_oper_log` VALUES (119, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 16:57:27');
INSERT INTO `sys_oper_log` VALUES (120, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"patient\",\"className\":\"Patient\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"患者id\",\"columnId\":19,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Sex\",\"columnComment\":\"性别，1、男 2、女 3、其他\",\"columnId\":20,\"columnName\":\"sex\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"sex\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Age\",\"columnComment\":\"年龄\",\"columnId\":21,\"columnName\":\"age\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"age\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Occupation\",\"columnComment\":\"职业\",\"columnId\":22,\"columnName\":\"occupation\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"occupation\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 17:18:05');
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 17:18:07');
INSERT INTO `sys_oper_log` VALUES (122, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"trajectory\",\"className\":\"Trajectory\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"轨迹id\",\"columnId\":27,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"患者id\",\"columnId\":28,\"columnName\":\"pid\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StartTime\",\"columnComment\":\"起始时间\",\"columnId\":29,\"columnName\":\"start_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"startTime\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EndTime\",\"columnComment\":\"结束时间\",\"columnId\":30,\"columnName\":\"end_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"endTime\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"quer', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 17:19:41');
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 17:19:47');
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"change\",\"className\":\"NumberChange\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":11,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StartTime\",\"columnComment\":\"起始时间\",\"columnId\":12,\"columnName\":\"start_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"startTime\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EndTime\",\"columnComment\":\"结束时间\",\"columnId\":13,\"columnName\":\"end_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"endTime\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Increase\",\"columnComment\":\"新增数\",\"columnId\":14,\"columnName\":\"increase\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"increase\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":tru', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 17:22:29');
INSERT INTO `sys_oper_log` VALUES (125, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 17:22:33');
INSERT INTO `sys_oper_log` VALUES (126, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"news\",\"className\":\"News\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"新闻id\",\"columnId\":6,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:54:15\",\"usableColumn\":false},{\"capJavaField\":\"Type\",\"columnComment\":\"新闻类型：1、区域时空行为新闻 2、患者个人信息新闻 3、患者时空行为新闻 4、区域病例数据新闻 5、其他\",\"columnId\":7,\"columnName\":\"type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"type\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:54:15\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"新闻标题\",\"columnId\":8,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:54:15\",\"usableColumn\":false},{\"capJavaField\":\"Link\",\"columnComment\":\"新闻链接\",\"columnId\":9,\"columnName\":\"link\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isL', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-29 17:40:37');
INSERT INTO `sys_oper_log` VALUES (127, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-29 17:40:40');
INSERT INTO `sys_oper_log` VALUES (128, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"新闻类型\",\"dictType\":\"eeas_news\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:31:50');
INSERT INTO `sys_oper_log` VALUES (129, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"区域时空行为新闻\",\"dictSort\":0,\"dictType\":\"eeas_news\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:36:14');
INSERT INTO `sys_oper_log` VALUES (130, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-09-30 17:36:14\",\"default\":false,\"dictCode\":100,\"dictLabel\":\"区域时空行为新闻\",\"dictSort\":1,\"dictType\":\"eeas_news\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:36:25');
INSERT INTO `sys_oper_log` VALUES (131, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"患者个人信息新闻 \",\"dictSort\":2,\"dictType\":\"eeas_news\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:36:58');
INSERT INTO `sys_oper_log` VALUES (132, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"患者时空行为新闻\",\"dictSort\":3,\"dictType\":\"eeas_news\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:37:10');
INSERT INTO `sys_oper_log` VALUES (133, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"区域病例数据新闻\",\"dictSort\":4,\"dictType\":\"eeas_news\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:37:26');
INSERT INTO `sys_oper_log` VALUES (134, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其他\",\"dictSort\":5,\"dictType\":\"eeas_news\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:37:39');
INSERT INTO `sys_oper_log` VALUES (135, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"事件\",\"dictType\":\"eeas_event\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:39:59');
INSERT INTO `sys_oper_log` VALUES (136, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"划定封控区\",\"dictSort\":1,\"dictType\":\"eeas_event\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:40:26');
INSERT INTO `sys_oper_log` VALUES (137, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"只出不进\",\"dictSort\":2,\"dictType\":\"eeas_event\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:40:38');
INSERT INTO `sys_oper_log` VALUES (138, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"停运\",\"dictSort\":3,\"dictType\":\"eeas_event\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:40:55');
INSERT INTO `sys_oper_log` VALUES (139, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"区间运营\",\"dictSort\":4,\"dictType\":\"eeas_event\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:41:07');
INSERT INTO `sys_oper_log` VALUES (140, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"关闭\",\"dictSort\":5,\"dictType\":\"eeas_event\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:41:30');
INSERT INTO `sys_oper_log` VALUES (141, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"划定高风险地区\",\"dictSort\":6,\"dictType\":\"eeas_event\",\"dictValue\":\"5\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:41:44');
INSERT INTO `sys_oper_log` VALUES (142, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"划定中风险地区\",\"dictSort\":7,\"dictType\":\"eeas_event\",\"dictValue\":\"6\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:41:54');
INSERT INTO `sys_oper_log` VALUES (143, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"划定管控区\",\"dictSort\":7,\"dictType\":\"eeas_event\",\"dictValue\":\"6\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:42:25');
INSERT INTO `sys_oper_log` VALUES (144, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"划定防范区\",\"dictSort\":8,\"dictType\":\"eeas_event\",\"dictValue\":\"7\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:42:35');
INSERT INTO `sys_oper_log` VALUES (145, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-09-30 17:42:25\",\"default\":false,\"dictCode\":112,\"dictLabel\":\"划定管控区\",\"dictSort\":8,\"dictType\":\"eeas_event\",\"dictValue\":\"7\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:42:48');
INSERT INTO `sys_oper_log` VALUES (146, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-09-30 17:42:35\",\"default\":false,\"dictCode\":113,\"dictLabel\":\"划定防范区\",\"dictSort\":9,\"dictType\":\"eeas_event\",\"dictValue\":\"8\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:42:53');
INSERT INTO `sys_oper_log` VALUES (147, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"全封闭管理\",\"dictSort\":10,\"dictType\":\"eeas_event\",\"dictValue\":\"9\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:43:27');
INSERT INTO `sys_oper_log` VALUES (148, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"暂停对外开放\",\"dictSort\":11,\"dictType\":\"eeas_event\",\"dictValue\":\"10\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:43:45');
INSERT INTO `sys_oper_log` VALUES (149, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"解除封控区管控\",\"dictSort\":12,\"dictType\":\"eeas_event\",\"dictValue\":\"11\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:44:30');
INSERT INTO `sys_oper_log` VALUES (150, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"恢复运营\",\"dictSort\":13,\"dictType\":\"eeas_event\",\"dictValue\":\"12\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:44:51');
INSERT INTO `sys_oper_log` VALUES (151, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"恢复部分运营\",\"dictSort\":14,\"dictType\":\"eeas_event\",\"dictValue\":\"13\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:45:03');
INSERT INTO `sys_oper_log` VALUES (152, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"恢复营业\",\"dictSort\":15,\"dictType\":\"eeas_event\",\"dictValue\":\"14\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:45:35');
INSERT INTO `sys_oper_log` VALUES (153, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"开放\",\"dictSort\":16,\"dictType\":\"eeas_event\",\"dictValue\":\"15\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:45:47');
INSERT INTO `sys_oper_log` VALUES (154, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"划定低风险地区\",\"dictSort\":17,\"dictType\":\"eeas_event\",\"dictValue\":\"16\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:46:05');
INSERT INTO `sys_oper_log` VALUES (155, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"解除管控区管控\",\"dictSort\":18,\"dictType\":\"eeas_event\",\"dictValue\":\"17\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:46:55');
INSERT INTO `sys_oper_log` VALUES (156, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"解除防范区管控\",\"dictSort\":19,\"dictType\":\"eeas_event\",\"dictValue\":\"18\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:47:08');
INSERT INTO `sys_oper_log` VALUES (157, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"开启\",\"dictSort\":20,\"dictType\":\"eeas_event\",\"dictValue\":\"19\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:48:05');
INSERT INTO `sys_oper_log` VALUES (158, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"开站\",\"dictSort\":21,\"dictType\":\"eeas_event\",\"dictValue\":\"20\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:48:21');
INSERT INTO `sys_oper_log` VALUES (159, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"分型\",\"dictType\":\"eeas_patient\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:49:36');
INSERT INTO `sys_oper_log` VALUES (160, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"无症状感染者\",\"dictSort\":1,\"dictType\":\"eeas_patient\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:49:51');
INSERT INTO `sys_oper_log` VALUES (161, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"轻型\",\"dictSort\":2,\"dictType\":\"eeas_patient\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:50:00');
INSERT INTO `sys_oper_log` VALUES (162, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"普通型\",\"dictSort\":3,\"dictType\":\"eeas_patient\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:50:11');
INSERT INTO `sys_oper_log` VALUES (163, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"重型\",\"dictSort\":4,\"dictType\":\"eeas_patient\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:50:24');
INSERT INTO `sys_oper_log` VALUES (164, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其他\",\"dictSort\":5,\"dictType\":\"eeas_patient\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:50:45');
INSERT INTO `sys_oper_log` VALUES (165, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"event\",\"className\":\"Event\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"事件id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:57:22\",\"usableColumn\":false},{\"capJavaField\":\"Time\",\"columnComment\":\"时间\",\"columnId\":2,\"columnName\":\"time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"time\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:57:22\",\"usableColumn\":false},{\"capJavaField\":\"Place\",\"columnComment\":\"场所\",\"columnId\":3,\"columnName\":\"place\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"place\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 16:57:22\",\"usableColumn\":false},{\"capJavaField\":\"Event\",\"columnComment\":\"事件，一一枚举\",\"columnId\":4,\"columnName\":\"event\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"eeas_event\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"jav', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:52:05');
INSERT INTO `sys_oper_log` VALUES (166, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"news\",\"className\":\"News\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"新闻id\",\"columnId\":6,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 17:40:37\",\"usableColumn\":false},{\"capJavaField\":\"Type\",\"columnComment\":\"新闻类型：1、区域时空行为新闻 2、患者个人信息新闻 3、患者时空行为新闻 4、区域病例数据新闻 5、其他\",\"columnId\":7,\"columnName\":\"type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"eeas_news\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"type\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 17:40:37\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"新闻标题\",\"columnId\":8,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 17:40:37\",\"usableColumn\":false},{\"capJavaField\":\"Link\",\"columnComment\":\"新闻链接\",\"columnId\":9,\"columnName\":\"link\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:52:25');
INSERT INTO `sys_oper_log` VALUES (167, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"patient\",\"className\":\"Patient\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"患者id\",\"columnId\":19,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 17:18:05\",\"usableColumn\":false},{\"capJavaField\":\"Sex\",\"columnComment\":\"性别，1、男 2、女 3、其他\",\"columnId\":20,\"columnName\":\"sex\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"sys_user_sex\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"sex\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 17:18:05\",\"usableColumn\":false},{\"capJavaField\":\"Age\",\"columnComment\":\"年龄\",\"columnId\":21,\"columnName\":\"age\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"age\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2022-09-29 17:18:05\",\"usableColumn\":false},{\"capJavaField\":\"Occupation\",\"columnComment\":\"职业\",\"columnId\":22,\"columnName\":\"occupation\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-09-30 17:52:47');
INSERT INTO `sys_oper_log` VALUES (168, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-30 17:53:28');
INSERT INTO `sys_oper_log` VALUES (169, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-30 17:53:29');
INSERT INTO `sys_oper_log` VALUES (170, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-09-30 17:53:30');
INSERT INTO `sys_oper_log` VALUES (171, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"http://baidu.com\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\实验室\\疫情演化分析系统\\eeas\\backend\\service\\target\\classes\\mapper\\NewsMapper.xml]\r\n### The error may involve com.ruoyi.eeas.mapper.NewsMapper.insertNews-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eeas_news          ( type,             title,             link,             content )           values ( ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2022-09-30 18:11:52');
INSERT INTO `sys_oper_log` VALUES (172, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"http://baidu.com\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\实验室\\疫情演化分析系统\\eeas\\backend\\service\\target\\classes\\mapper\\NewsMapper.xml]\r\n### The error may involve com.ruoyi.eeas.mapper.NewsMapper.insertNews-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eeas_news          ( type,             title,             link,             content )           values ( ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2022-09-30 18:59:55');
INSERT INTO `sys_oper_log` VALUES (173, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"http://baidu.com\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\实验室\\疫情演化分析系统\\eeas\\backend\\service\\target\\classes\\mapper\\NewsMapper.xml]\r\n### The error may involve com.ruoyi.eeas.mapper.NewsMapper.insertNews-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eeas_news          ( type,             title,             link,             content )           values ( ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2022-09-30 19:06:55');
INSERT INTO `sys_oper_log` VALUES (174, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"https://baidu.com\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'id\' cannot be null\r\n### The error may exist in file [D:\\实验室\\疫情演化分析系统\\eeas\\backend\\service\\target\\classes\\mapper\\NewsMapper.xml]\r\n### The error may involve com.ruoyi.eeas.mapper.NewsMapper.insertNews-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eeas_news          ( id,             type,             title,             link,             content )           values ( ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'id\' cannot be null\n; Column \'id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'id\' cannot be null', '2022-09-30 19:17:38');
INSERT INTO `sys_oper_log` VALUES (175, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"test\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\实验室\\疫情演化分析系统\\eeas\\backend\\service\\target\\classes\\mapper\\NewsMapper.xml]\r\n### The error may involve com.ruoyi.eeas.mapper.NewsMapper.insertNews-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eeas_news          ( type,             title,             link,             content )           values ( ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2022-09-30 19:25:40');
INSERT INTO `sys_oper_log` VALUES (176, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"test\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, 'Invalid bound statement (not found): com.ruoyi.eeas.mapper.NewsMapper.insert', '2022-09-30 19:42:05');
INSERT INTO `sys_oper_log` VALUES (177, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"test\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, 'Invalid bound statement (not found): com.ruoyi.eeas.mapper.NewsMapper.insert', '2022-10-01 15:03:23');
INSERT INTO `sys_oper_log` VALUES (178, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"test\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, 'Invalid bound statement (not found): com.ruoyi.eeas.mapper.NewsMapper.insert', '2022-10-01 15:15:52');
INSERT INTO `sys_oper_log` VALUES (179, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"test\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, 'Invalid bound statement (not found): com.ruoyi.eeas.mapper.NewsMapper.insert', '2022-10-01 15:18:00');
INSERT INTO `sys_oper_log` VALUES (180, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"test\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/eeas/mapper/NewsMapper.java (best guess)\r\n### The error may involve com.ruoyi.eeas.mapper.NewsMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-10-01 15:33:48');
INSERT INTO `sys_oper_log` VALUES (181, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>test</p>\",\"link\":\"test\",\"params\":{},\"title\":\"test\",\"type\":0}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/eeas/mapper/NewsMapper.java (best guess)\r\n### The error may involve com.ruoyi.eeas.mapper.NewsMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2022-10-01 15:35:59');
INSERT INTO `sys_oper_log` VALUES (182, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>1</p>\",\"id\":1576117076773695489,\"link\":\"1\",\"params\":{},\"title\":\"1\",\"type\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 15:49:28');
INSERT INTO `sys_oper_log` VALUES (183, '新闻数据', 3, 'com.ruoyi.eeas.controller.NewsController.remove()', 'DELETE', 1, 'admin', NULL, '/data/news/1576117076773695500', '127.0.0.1', '内网IP', '{ids=1576117076773695500}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2022-10-01 15:55:27');
INSERT INTO `sys_oper_log` VALUES (184, '新闻数据', 3, 'com.ruoyi.eeas.controller.NewsController.remove()', 'DELETE', 1, 'admin', NULL, '/data/news/1576117076773695500', '127.0.0.1', '内网IP', '{ids=1576117076773695500}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2022-10-01 15:55:55');
INSERT INTO `sys_oper_log` VALUES (185, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>2</p>\",\"id\":1576119416645873666,\"link\":\"2\",\"params\":{},\"title\":\"2\",\"type\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 15:58:47');
INSERT INTO `sys_oper_log` VALUES (186, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>3</p>\",\"id\":1576122119245656066,\"link\":\"3\",\"params\":{},\"title\":\"3\",\"type\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:09:30');
INSERT INTO `sys_oper_log` VALUES (187, '轨迹数据', 1, 'com.ruoyi.eeas.controller.TrajectoryController.add()', 'POST', 1, 'admin', NULL, '/data/trajectory', '127.0.0.1', '内网IP', '{\"endTime\":\"2022-10-03 00:00:00\",\"latitude\":\"\",\"longitude\":\"\",\"params\":{},\"pid\":1,\"place\":\"1\",\"rawText\":\"1\",\"source\":1,\"startTime\":\"2022-10-01 00:00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\实验室\\疫情演化分析系统\\eeas\\backend\\service\\target\\classes\\mapper\\TrajectoryMapper.xml]\r\n### The error may involve com.ruoyi.eeas.mapper.TrajectoryMapper.insertTrajectory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eeas_trajectory          ( pid,             start_time,             end_time,             place,             longitude,             latitude,                          raw_text,             source )           values ( ?,             ?,             ?,             ?,             ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2022-10-01 16:14:11');
INSERT INTO `sys_oper_log` VALUES (188, '新闻数据', 1, 'com.ruoyi.eeas.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>4</p>\",\"id\":1576123515038699521,\"link\":\"4\",\"params\":{},\"title\":\"4\",\"type\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:15:03');
INSERT INTO `sys_oper_log` VALUES (189, '新闻数据', 2, 'com.ruoyi.eeas.controller.NewsController.edit()', 'PUT', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', '{\"content\":\"<p>4-1</p>\",\"id\":1576123515038699521,\"link\":\"4\",\"params\":{},\"title\":\"4\",\"type\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:15:13');
INSERT INTO `sys_oper_log` VALUES (190, '新闻数据', 3, 'com.ruoyi.eeas.controller.NewsController.remove()', 'DELETE', 1, 'admin', NULL, '/data/news/1576122119245656066', '127.0.0.1', '内网IP', '{ids=1576122119245656066}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:15:44');
INSERT INTO `sys_oper_log` VALUES (191, '事件数据', 1, 'com.ruoyi.eeas.controller.EventController.add()', 'POST', 1, 'admin', NULL, '/data/event', '127.0.0.1', '内网IP', '{\"event\":1,\"id\":1576128120501854210,\"params\":{},\"place\":\"1\",\"source\":1,\"time\":\"2022-10-01 00:00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\实验室\\疫情演化分析系统\\eeas\\backend\\service\\target\\classes\\mapper\\EventMapper.xml]\r\n### The error may involve com.ruoyi.eeas.mapper.EventMapper.insertEvent-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into eeas_event          ( time,             place,             event,             source )           values ( ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2022-10-01 16:33:21');
INSERT INTO `sys_oper_log` VALUES (192, '事件数据', 1, 'com.ruoyi.eeas.controller.EventController.add()', 'POST', 1, 'admin', NULL, '/data/event', '127.0.0.1', '内网IP', '{\"event\":1,\"id\":1576128677144707073,\"params\":{},\"place\":\"1\",\"source\":1,\"time\":\"2022-10-01 00:00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`eeas`.`eeas_event`, CONSTRAINT `eeas_event_ibfk_1` FOREIGN KEY (`source`) REFERENCES `eeas_news` (`id`))\r\n### The error may exist in com/ruoyi/eeas/mapper/EventMapper.java (best guess)\r\n### The error may involve com.ruoyi.eeas.mapper.EventMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO eeas_event  ( id, time, place, event, source )  VALUES  ( ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`eeas`.`eeas_event`, CONSTRAINT `eeas_event_ibfk_1` FOREIGN KEY (`source`) REFERENCES `eeas_news` (`id`))\n; Cannot add or update a child row: a foreign key constraint fails (`eeas`.`eeas_event`, CONSTRAINT `eeas_event_ibfk_1` FOREIGN KEY (`source`) REFERENCES `eeas_news` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`eeas`.`eeas_event`, CONSTRAINT `eeas_event_ibfk_1` FOREIGN KEY (`source`) REFERENCES `eeas_news` (`id`))', '2022-10-01 16:35:34');
INSERT INTO `sys_oper_log` VALUES (193, '事件数据', 1, 'com.ruoyi.eeas.controller.EventController.add()', 'POST', 1, 'admin', NULL, '/data/event', '127.0.0.1', '内网IP', '{\"event\":1,\"id\":1576128700527951874,\"params\":{},\"place\":\"1\",\"source\":1576117076773695489,\"time\":\"2022-10-01 00:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:35:40');
INSERT INTO `sys_oper_log` VALUES (194, '事件数据', 1, 'com.ruoyi.eeas.controller.EventController.add()', 'POST', 1, 'admin', NULL, '/data/event', '127.0.0.1', '内网IP', '{\"event\":2,\"id\":1576128942023393282,\"params\":{},\"place\":\"2\",\"source\":1576117076773695489,\"time\":\"2022-10-01 00:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:36:37');
INSERT INTO `sys_oper_log` VALUES (195, '患者数据', 1, 'com.ruoyi.eeas.controller.PatientController.add()', 'POST', 1, 'admin', NULL, '/data/patient', '127.0.0.1', '内网IP', '{\"address\":\"1\",\"age\":10,\"id\":1576129319481393153,\"occupation\":\"1\",\"params\":{},\"sex\":0,\"type\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:38:07');
INSERT INTO `sys_oper_log` VALUES (196, '患者数据', 1, 'com.ruoyi.eeas.controller.PatientController.add()', 'POST', 1, 'admin', NULL, '/data/patient', '127.0.0.1', '内网IP', '{\"address\":\"2\",\"age\":11,\"id\":1576129399634542594,\"occupation\":\"2\",\"params\":{},\"sex\":1,\"source1\":1576117076773695489,\"source2\":1576117076773695489,\"type\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:38:26');
INSERT INTO `sys_oper_log` VALUES (197, '轨迹数据', 1, 'com.ruoyi.eeas.controller.TrajectoryController.add()', 'POST', 1, 'admin', NULL, '/data/trajectory', '127.0.0.1', '内网IP', '{\"id\":1576129477430493186,\"params\":{},\"pid\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`eeas`.`eeas_trajectory`, CONSTRAINT `eeas_trajectory_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `eeas_patient` (`id`))\r\n### The error may exist in com/ruoyi/eeas/mapper/TrajectoryMapper.java (best guess)\r\n### The error may involve com.ruoyi.eeas.mapper.TrajectoryMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO eeas_trajectory  ( id, pid )  VALUES  ( ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`eeas`.`eeas_trajectory`, CONSTRAINT `eeas_trajectory_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `eeas_patient` (`id`))\n; Cannot add or update a child row: a foreign key constraint fails (`eeas`.`eeas_trajectory`, CONSTRAINT `eeas_trajectory_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `eeas_patient` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`eeas`.`eeas_trajectory`, CONSTRAINT `eeas_trajectory_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `eeas_patient` (`id`))', '2022-10-01 16:38:45');
INSERT INTO `sys_oper_log` VALUES (198, '轨迹数据', 1, 'com.ruoyi.eeas.controller.TrajectoryController.add()', 'POST', 1, 'admin', NULL, '/data/trajectory', '127.0.0.1', '内网IP', '{\"endTime\":\"2022-10-01 00:00:00\",\"id\":1576129610008248322,\"params\":{},\"pid\":1576129319481393153,\"place\":\"1\",\"rawText\":\"1\",\"source\":1576117076773695489,\"startTime\":\"2022-10-01 00:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:39:16');
INSERT INTO `sys_oper_log` VALUES (199, '病例变化数据', 1, 'com.ruoyi.eeas.controller.NumberChangeController.add()', 'POST', 1, 'admin', NULL, '/data/change', '127.0.0.1', '内网IP', '{\"closeContact\":1,\"diagnosis\":1,\"endTime\":\"2022-10-01 00:00:00\",\"id\":1576129754766262274,\"increase\":1,\"medicalObservation\":1,\"params\":{},\"source\":1576117076773695489,\"startTime\":\"2022-10-01 00:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:39:51');
INSERT INTO `sys_oper_log` VALUES (200, '事件数据', 1, 'com.ruoyi.eeas.controller.EventController.add()', 'POST', 1, 'admin', NULL, '/data/event', '127.0.0.1', '内网IP', '{\"event\":3,\"id\":1576129835603083266,\"params\":{},\"place\":\"3\",\"source\":1576117076773695489,\"time\":\"2022-10-01 00:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:40:10');
INSERT INTO `sys_oper_log` VALUES (201, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"event\",\"className\":\"Event\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"事件id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-09-30 17:52:05\",\"usableColumn\":false},{\"capJavaField\":\"Time\",\"columnComment\":\"时间\",\"columnId\":2,\"columnName\":\"time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"time\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-09-30 17:52:05\",\"usableColumn\":false},{\"capJavaField\":\"Place\",\"columnComment\":\"场所\",\"columnId\":3,\"columnName\":\"place\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"place\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-09-30 17:52:05\",\"usableColumn\":false},{\"capJavaField\":\"Event\",\"columnComment\":\"事件，一一枚举\",\"columnId\":4,\"columnName\":\"event\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"eeas_event\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"jav', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:42:06');
INSERT INTO `sys_oper_log` VALUES (202, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"event\",\"className\":\"Event\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"事件id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-10-01 16:42:06\",\"usableColumn\":false},{\"capJavaField\":\"Time\",\"columnComment\":\"时间\",\"columnId\":2,\"columnName\":\"time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"time\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-10-01 16:42:06\",\"usableColumn\":false},{\"capJavaField\":\"Place\",\"columnComment\":\"场所\",\"columnId\":3,\"columnName\":\"place\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"place\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-10-01 16:42:06\",\"usableColumn\":false},{\"capJavaField\":\"Event\",\"columnComment\":\"事件，一一枚举\",\"columnId\":4,\"columnName\":\"event\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2022-09-29 15:12:32\",\"dictType\":\"eeas_event\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"ja', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:49:29');
INSERT INTO `sys_oper_log` VALUES (203, '事件数据', 1, 'com.ruoyi.eeas.controller.EventController.add()', 'POST', 1, 'admin', NULL, '/data/event', '127.0.0.1', '内网IP', '{\"event\":17,\"id\":1576132565591670785,\"params\":{},\"place\":\"4\",\"source\":1576119416645873666,\"time\":\"2022-09-30 00:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:51:01');
INSERT INTO `sys_oper_log` VALUES (204, '事件数据', 2, 'com.ruoyi.eeas.controller.EventController.edit()', 'PUT', 1, 'admin', NULL, '/data/event', '127.0.0.1', '内网IP', '{\"event\":11,\"id\":1576132565591670785,\"params\":{},\"place\":\"4-1\",\"source\":1576119416645873666,\"time\":\"2022-09-30 00:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-10-01 16:51:17');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(0) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-09-17 12:49:09', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-09-17 12:49:09', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-09-17 12:49:09', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-09-17 12:49:09', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(0) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-09-17 12:49:11', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (3, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2022-09-17 12:49:11', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(0) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(0) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(0) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-10-02 11:10:34', 'admin', '2022-09-17 12:49:08', '', '2022-10-02 11:10:33', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-09-17 16:31:09', 'admin', '2022-09-17 12:49:08', '', '2022-09-17 16:31:08', '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `post_id` bigint(0) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
