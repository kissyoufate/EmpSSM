/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : emp

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2017-12-31 18:07:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_department`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_department`;
CREATE TABLE `tbl_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(20) DEFAULT NULL,
  `dep_des` varchar(255) DEFAULT NULL,
  `dep_mark` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_department
-- ----------------------------
INSERT INTO `tbl_department` VALUES ('1', '1', '1', '1');
INSERT INTO `tbl_department` VALUES ('2', '开发部', '555', '1');

-- ----------------------------
-- Table structure for `tbl_empolyee`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_empolyee`;
CREATE TABLE `tbl_empolyee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(50) DEFAULT NULL,
  `emp_sex` varchar(5) DEFAULT NULL,
  `emp_age` int(11) DEFAULT NULL,
  `emp_tel` varchar(11) DEFAULT NULL,
  `dep_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_empolyee
-- ----------------------------
INSERT INTO `tbl_empolyee` VALUES ('1', '1', '22', '1', '11111111111', '1');
INSERT INTO `tbl_empolyee` VALUES ('2', '王刚', '27', '1', '13296540788', '1');
