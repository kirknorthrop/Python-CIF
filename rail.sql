-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 14, 2012 at 12:00 PM
-- Server version: 5.1.63
-- PHP Version: 5.3.3-7+squeeze14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rail`
--

-- --------------------------------------------------------

--
-- Table structure for table `associations`
--

CREATE TABLE IF NOT EXISTS `associations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `main_train_uid` char(6) NOT NULL,
  `assoc_train_uid` char(6) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `runs_mo` tinyint(1) NOT NULL,
  `runs_tu` tinyint(1) NOT NULL,
  `runs_we` tinyint(1) NOT NULL,
  `runs_th` tinyint(1) NOT NULL,
  `runs_fr` tinyint(1) NOT NULL,
  `runs_sa` tinyint(1) NOT NULL,
  `runs_su` tinyint(1) NOT NULL,
  `category` enum('JJ','VV','NP') NOT NULL,
  `date_indicator` enum('S','N','P') NOT NULL,
  `location` char(7) NOT NULL,
  `base_location_suffix` enum('2','3','4','5','6','7','8','9') DEFAULT NULL,
  `assoc_location_suffix` enum('2','3','4','5','6','7','8','9') DEFAULT NULL,
  `assoc_type` enum('O','P') DEFAULT NULL,
  `stp_indicator` enum('P','O','N') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date_from` (`date_from`),
  KEY `date_to` (`date_to`),
  KEY `assoc_mo` (`runs_mo`),
  KEY `assoc_tu` (`runs_tu`),
  KEY `assoc_we` (`runs_we`),
  KEY `assoc_th` (`runs_th`),
  KEY `assoc_fr` (`runs_fr`),
  KEY `assoc_sa` (`runs_sa`),
  KEY `assoc_su` (`runs_su`),
  KEY `location` (`location`),
  KEY `main_train_uid` (`main_train_uid`),
  KEY `assoc_train_uid` (`assoc_train_uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=63664 ;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(11) DEFAULT NULL,
  `location_order` smallint(6) DEFAULT NULL,
  `location_type` enum('LO','LI','LT') DEFAULT NULL,
  `tiploc_code` char(7) DEFAULT NULL,
  `tiploc_instance` enum('2','3','4','5','6','7','8','9') DEFAULT NULL,
  `arrival` char(5) DEFAULT NULL,
  `public_arrival` char(4) DEFAULT NULL,
  `pass` char(5) DEFAULT NULL,
  `departure` char(5) DEFAULT NULL,
  `public_departure` char(4) DEFAULT NULL,
  `platform` char(3) DEFAULT NULL,
  `line` char(3) DEFAULT NULL,
  `path` char(3) DEFAULT NULL,
  `engineering_allowance` char(2) DEFAULT NULL,
  `pathing_allowance` char(2) DEFAULT NULL,
  `performance_allowance` char(2) DEFAULT NULL,
  `activity` char(12) DEFAULT NULL,
  `public_call` tinyint(1) DEFAULT '0',
  `actual_call` tinyint(1) DEFAULT '0',
  `order_time` char(5) DEFAULT NULL,
  KEY `id` (`id`),
  KEY `location_type` (`location_type`),
  KEY `tiploc_code` (`tiploc_code`),
  KEY `order_time` (`order_time`),
  KEY `public_call` (`public_call`),
  KEY `actual_call` (`actual_call`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE IF NOT EXISTS `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `train_uid` char(6) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `runs_mo` tinyint(1) NOT NULL,
  `runs_tu` tinyint(1) NOT NULL,
  `runs_we` tinyint(1) NOT NULL,
  `runs_th` tinyint(1) NOT NULL,
  `runs_fr` tinyint(1) NOT NULL,
  `runs_sa` tinyint(1) NOT NULL,
  `runs_su` tinyint(1) NOT NULL,
  `bank_holiday_running` enum('X','G') DEFAULT NULL,
  `train_status` enum('1','2','3','4','5','B','F','P','S','T') NOT NULL,
  `category` char(2) NOT NULL,
  `train_identity` char(4) NOT NULL,
  `headcode` char(4) NOT NULL,
  `train_service_code` char(8) NOT NULL,
  `portion_id` enum('1','2','4','8','Z') NOT NULL,
  `power_type` enum('D','DEM','DMU','E','ED','EML','EMU','EPU','HST','LDS') DEFAULT NULL,
  `timing_load` char(4) DEFAULT NULL,
  `speed` char(3) NOT NULL,
  `operating_characteristics` char(6) DEFAULT NULL,
  `train_class` enum('B','S') DEFAULT NULL,
  `sleepers` enum('B','S','F') DEFAULT NULL,
  `reservations` enum('A','R','S','E') DEFAULT NULL,
  `catering_code` char(4) DEFAULT NULL,
  `service_branding` char(4) NOT NULL,
  `stp_indicator` enum('P','N','O') NOT NULL,
  `uic_code` char(5) NOT NULL,
  `atoc_code` char(2) NOT NULL,
  `ats_code` enum('Y','N') NOT NULL,
  `rsid` char(8) NOT NULL,
  `data_source` enum('0','T') NOT NULL,
  `applicable_timetable` varchar(100) NOT NULL,
  `connection_indicator` varchar(100) DEFAULT NULL,
  `business_sector` varchar(100) NOT NULL,
  `course_indicator` varchar(100) NOT NULL,
  `train_category` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `train_uid` (`train_uid`),
  KEY `date_from` (`start_date`),
  KEY `date_to` (`end_date`),
  KEY `runs_mo` (`runs_mo`),
  KEY `runs_tu` (`runs_tu`),
  KEY `runs_we` (`runs_we`),
  KEY `runs_th` (`runs_th`),
  KEY `runs_fr` (`runs_fr`),
  KEY `runs_sa` (`runs_sa`),
  KEY `runs_su` (`runs_su`),
  KEY `stp_indicator` (`stp_indicator`),
  KEY `train_identity` (`train_identity`),
  KEY `bank_hol` (`bank_holiday_running`),
  KEY `status` (`train_status`),
  KEY `atoc_code` (`atoc_code`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=345354 ;

-- --------------------------------------------------------

--
-- Table structure for table `stations`
--

CREATE TABLE IF NOT EXISTS `stations` (
  `tiploc` char(7) NOT NULL DEFAULT '',
  `crs` char(3) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`tiploc`),
  UNIQUE KEY `crs` (`crs`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tiploc`
--

CREATE TABLE IF NOT EXISTS `tiploc` (
  `tiploc` char(7) NOT NULL,
  `nlc` char(6) NOT NULL,
  `tps_description` char(26) NOT NULL DEFAULT '',
  `stanox` char(5) NOT NULL,
  `crs_code` char(3) NOT NULL,
  `short_description` char(16) NOT NULL,
  PRIMARY KEY (`tiploc`),
  KEY `crs_code` (`crs_code`),
  KEY `stanox` (`stanox`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `updates`
--

CREATE TABLE IF NOT EXISTS `updates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `file` char(7) NOT NULL DEFAULT '',
  `user` char(6) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `update_type` enum('F','U') NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
