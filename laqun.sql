-- MySQL dump 10.16  Distrib 10.3.9-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: laqun
-- ------------------------------------------------------
-- Server version	10.3.9-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addFriendVerify`
--

DROP TABLE IF EXISTS `addFriendVerify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addFriendVerify` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '添加好友验证内容',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueVal` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `addQun`
--

DROP TABLE IF EXISTS `addQun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addQun` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qunQr` varchar(108) NOT NULL DEFAULT '' COMMENT '群二维码内容',
  `qunid` varchar(108) NOT NULL DEFAULT '' COMMENT '群id',
  `nick` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称',
  `sn` varchar(255) NOT NULL DEFAULT '' COMMENT '对应的手机',
  `laNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '允许拉人的数量',
  `laedNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '已经拉的数量',
  `laTimeout` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '这个群从拉人到拉完允许的超时时间，单位到秒',
  `lastGetTime` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '最后一次被手机获取去拉人的时间，用来计算超时，单位秒，时间戳',
  `priority` tinyint(4) NOT NULL DEFAULT 1 COMMENT '优先级，1-5',
  `customer` varchar(255) NOT NULL DEFAULT '' COMMENT '资源所属客户',
  `isUse` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否正在使用，0否，1是',
  `friendNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '目前群成员数量',
  `isBad` tinyint(4) NOT NULL DEFAULT 0 COMMENT '群是否异常了，0否，1是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `qunQr` (`qunQr`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `addWx`
--

DROP TABLE IF EXISTS `addWx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addWx` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone` char(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `wxid` varchar(108) NOT NULL DEFAULT '' COMMENT '对应的wxid或微信号',
  `nick` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '性别，0未知，1男，2女',
  `province` varchar(255) NOT NULL DEFAULT '' COMMENT '省',
  `city` varchar(255) NOT NULL DEFAULT '' COMMENT '市',
  `isLa` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否被拉过，0没拉，1拉过',
  `laTime` char(19) NOT NULL DEFAULT '' COMMENT '被拉的时间',
  `laQunId` varchar(50) NOT NULL DEFAULT '' COMMENT '被拉的群id',
  `priority` tinyint(4) NOT NULL DEFAULT 1 COMMENT '优先级，1-5',
  `customer` varchar(255) NOT NULL DEFAULT '' COMMENT '资源所属客户',
  `isUse` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否正在使用，0否，1是',
  `avatar` text NOT NULL DEFAULT '' COMMENT '头像base64',
  `isFriend` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否通过了好友验证，0否，1是',
  `loginWx` varchar(255) NOT NULL DEFAULT '' COMMENT '被添加的对应的登录微信号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniquePhone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `avatar`
--

DROP TABLE IF EXISTS `avatar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avatar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '头像的文件名',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueName` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backImg`
--

DROP TABLE IF EXISTS `backImg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backImg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '朋友圈背景的文件名',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueName` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '评论值',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueVal` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '客户名称',
  `addNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '添加好友的数量',
  `friendNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '已经成为好友的数量',
  `laNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '被拉群的数量',
  `addTime` datetime NOT NULL DEFAULT current_timestamp() COMMENT '添加时间',
  `oddNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '剩余添加好友数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueName` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ipConf`
--

DROP TABLE IF EXISTS `ipConf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipConf` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ipAddr` varchar(15) NOT NULL DEFAULT '' COMMENT 'ip地址',
  `useNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'ip使用次数',
  `lastUseTime` char(19) NOT NULL DEFAULT '' COMMENT '该ip最后使用时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueIpAddr` (`ipAddr`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobStopLog`
--

DROP TABLE IF EXISTS `jobStopLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobStopLog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '任务停止日志表',
  `sn` varchar(50) NOT NULL DEFAULT '' COMMENT '任务所在手机',
  `stopContent` varchar(255) NOT NULL DEFAULT '' COMMENT '任务停止原因',
  `stopTime` datetime NOT NULL DEFAULT current_timestamp() COMMENT '停止时间',
  `jobName` varchar(255) NOT NULL DEFAULT '' COMMENT '任务名称',
  `jobContent` text DEFAULT NULL COMMENT '任务内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loginWx`
--

DROP TABLE IF EXISTS `loginWx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loginWx` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wxName` varchar(255) NOT NULL DEFAULT '' COMMENT '微信号',
  `wxPassword` varchar(255) NOT NULL DEFAULT '' COMMENT '微信密码',
  `wxid` varchar(255) NOT NULL DEFAULT '' COMMENT 'wxid',
  `avatarBase64` text DEFAULT NULL COMMENT '头像',
  `nick` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称',
  `addNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '可以添加好友的数量',
  `addedNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '已经添加好友的数量',
  `state` varchar(2000) NOT NULL DEFAULT '' COMMENT '状态',
  `sn` varchar(50) NOT NULL DEFAULT '' COMMENT '登录所在的手机sn',
  `yjInfo` mediumtext NOT NULL DEFAULT '' COMMENT '对硬件信息',
  `lastGetTime` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '微信号最后使用时间',
  `jobState` varchar(255) NOT NULL DEFAULT '' COMMENT '微信功能受损状态',
  `friendNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '目前好友总数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueWxName` (`wxName`, `wxid`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loginWxFriendChange`
--

DROP TABLE IF EXISTS `loginWxFriendChange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loginWxFriendChange` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '登录微信的好友变化表',
  `wxid` varchar(255) NOT NULL DEFAULT '' COMMENT '微信号',
  `friendNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '好友数量',
  `changeTime` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '变化时间，时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moments`
--

DROP TABLE IF EXISTS `moments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '发圈值',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueVal` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `momentsImg`
--

DROP TABLE IF EXISTS `momentsImg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `momentsImg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '发圈的图片的文件名',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueName` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `newsName` varchar(255) NOT NULL DEFAULT '' COMMENT '新闻名称',
  `newsUrl` varchar(255) NOT NULL DEFAULT '' COMMENT '新闻url',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueName` (`newsName`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nick`
--

DROP TABLE IF EXISTS `nick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nick` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称值',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueVal` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sign`
--

DROP TABLE IF EXISTS `sign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sign` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '签名值',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueVal` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sn`
--

DROP TABLE IF EXISTS `sn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sn` varchar(50) NOT NULL DEFAULT '' COMMENT '手机的sn号',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  `currentState` varchar(255) NOT NULL DEFAULT '' COMMENT '手机当前的状态',
  `jobName` varchar(255) NOT NULL DEFAULT '任务已停止' COMMENT '任务名称',
  `jobContent` text DEFAULT NULL COMMENT '任务内容',
  `lastHttpTime` char(19) NOT NULL DEFAULT '' COMMENT '手机最后跟服务器的通信时间',
  `appVer` varchar(10) NOT NULL DEFAULT '' COMMENT '当前手机端app版本',
  `goodWxNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '正常微信数量',
  `badWxNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '异常微信数量',
  `currentWx` varchar(255) NOT NULL DEFAULT '' COMMENT '当前登录的微信号',
  `remark` varchar(255) not null DEFAULT '' comment '备注'，
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueSn` (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `snGroup`
--

DROP TABLE IF EXISTS `snGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snGroup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `groupName` varchar(255) NOT NULL DEFAULT '' COMMENT '组名称',
  `groupMember` mediumtext NOT NULL DEFAULT '' COMMENT '组成员，用json表示',
  `addTime` datetime NOT NULL DEFAULT current_timestamp() COMMENT '创建时间，默认是创建的时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueName` (`groupName`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `talkChatRoom`
--

DROP TABLE IF EXISTS `talkChatRoom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talkChatRoom` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qunQr` varchar(255) NOT NULL DEFAULT '' COMMENT '群二维码内容',
  `qunid` varchar(255) NOT NULL DEFAULT '' COMMENT '群id',
  `nick` varchar(255) NOT NULL DEFAULT '' COMMENT '群名称',
  `friendNum` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '群成员数量，默认35,手机端获取一次就减一，到0则不能获取',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueQunQr` (`qunQr`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `talkContent`
--

DROP TABLE IF EXISTS `talkContent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talkContent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '聊天内容',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueVal` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `talkFriend`
--

DROP TABLE IF EXISTS `talkFriend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talkFriend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wxName` varchar(255) NOT NULL DEFAULT '' COMMENT '微信号',
  `isEnable` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否启用，1是，0否',
  `isClose` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否封号，1是，0否',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueWxName` (`wxName`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-08 16:13:56

CREATE TABLE `resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `val` varchar(255) NOT NULL DEFAULT '' COMMENT '聊天内容',
  `addTime` datetime NOT NULL DEFAULT current_timestamp(),
  `type` varchar(50) not null DEFAULT '' comment '资源类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueVal` (`val`, `type`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;