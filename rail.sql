-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 20, 2012 at 09:27 PM
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
-- Table structure for table `activation`
--

CREATE TABLE IF NOT EXISTS `activation` (
  `schedule_id` int(11) DEFAULT NULL,
  `creation_timestamp` datetime DEFAULT NULL,
  `d1266_record_number` varchar(5) DEFAULT NULL,
  `msg_queue_timestamp` datetime DEFAULT NULL,
  `origin_dep_timestamp` datetime DEFAULT NULL,
  `sched_origin_stanox` varchar(5) DEFAULT NULL,
  `schedule_end_date` date DEFAULT NULL,
  `schedule_source` varchar(1) DEFAULT NULL,
  `schedule_start_date` date DEFAULT NULL,
  `schedule_type` varchar(1) DEFAULT NULL,
  `schedule_wtt_id` varchar(5) DEFAULT NULL,
  `toc_id` varchar(2) DEFAULT NULL,
  `tp_origin_stanox` varchar(5) DEFAULT NULL,
  `tp_origin_timestamp` date DEFAULT NULL,
  `train_id` varchar(10) DEFAULT NULL,
  `train_service_code` varchar(8) DEFAULT NULL,
  `train_uid` varchar(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `association`
--

CREATE TABLE IF NOT EXISTS `association` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `main_train_uid` char(6) NOT NULL,
  `assoc_train_uid` char(6) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
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
  `type` enum('O','P') DEFAULT NULL,
  `stp_indicator` enum('P','O','N') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date_from` (`start_date`),
  KEY `date_to` (`end_date`),
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2819 ;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `id` int(11) DEFAULT NULL,
  `order` smallint(6) DEFAULT NULL,
  `type` enum('LO','LI','LT') DEFAULT NULL,
  `tiploc_code` varchar(7) DEFAULT NULL,
  `tiploc_instance` enum('2','3','4','5','6','7','8','9') DEFAULT NULL,
  `arrival` time DEFAULT NULL,
  `public_arrival` time DEFAULT NULL,
  `pass` time DEFAULT NULL,
  `departure` time DEFAULT NULL,
  `public_departure` time DEFAULT NULL,
  `platform` varchar(3) DEFAULT NULL,
  `line` varchar(3) DEFAULT NULL,
  `path` varchar(3) DEFAULT NULL,
  `engineering_allowance` varchar(2) DEFAULT NULL,
  `pathing_allowance` varchar(2) DEFAULT NULL,
  `performance_allowance` varchar(2) DEFAULT NULL,
  `activity` varchar(12) DEFAULT NULL,
  `public_call` tinyint(1) DEFAULT '0',
  `actual_call` tinyint(1) DEFAULT '0',
  KEY `id` (`id`),
  KEY `location_type` (`type`),
  KEY `tiploc_code` (`tiploc_code`),
  KEY `public_call` (`public_call`),
  KEY `actual_call` (`actual_call`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `movement`
--

CREATE TABLE IF NOT EXISTS `movement` (
  `correction_ind` tinyint(1) DEFAULT NULL,
  `current_train_id` varchar(8) DEFAULT NULL,
  `delay_monitoring_point` tinyint(1) DEFAULT NULL,
  `dep_timestamp` datetime DEFAULT NULL,
  `direction_ind` enum('UP','DOWN') DEFAULT NULL,
  `event_timestamp` datetime DEFAULT NULL,
  `event_type` enum('ARRIVAL','DEPARTURE','AT ORIGIN','EN ROUTE') DEFAULT NULL,
  `gbtt_timestamp` datetime DEFAULT NULL,
  `line_ind` varchar(1) DEFAULT NULL,
  `loc_stanox` varchar(5) DEFAULT NULL,
  `msg_queue_timestamp` datetime DEFAULT NULL,
  `msg_type` int(1) DEFAULT NULL,
  `next_report_run_time` int(11) DEFAULT NULL,
  `next_report_stanox` varchar(5) DEFAULT NULL,
  `original_loc_stanox` varchar(5) DEFAULT NULL,
  `original_loc_timestamp` datetime DEFAULT NULL,
  `planned_event_type` enum('ARRIVAL','DEPARTURE','DESTINATION') DEFAULT NULL,
  `planned_timestamp` datetime DEFAULT NULL,
  `platform` varchar(3) DEFAULT NULL,
  `reason_code` varchar(2) DEFAULT NULL,
  `reporting_stanox` varchar(5) DEFAULT NULL,
  `revised_train_id` varchar(8) DEFAULT NULL,
  `route` varchar(1) DEFAULT NULL,
  `timetable_variation` int(11) DEFAULT NULL,
  `toc_id` varchar(2) DEFAULT NULL,
  `train_id` varchar(10) DEFAULT NULL,
  `train_service_code` varchar(8) DEFAULT NULL,
  `train_terminated` tinyint(1) DEFAULT NULL,
  `variation_status` enum('EARLY','ON TIME','LATE','OFF ROUTE') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE IF NOT EXISTS `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `train_uid` varchar(6) NOT NULL,
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
  `category` varchar(2) NOT NULL,
  `train_identity` varchar(4) NOT NULL,
  `headcode` varchar(4) NOT NULL,
  `train_service_code` varchar(8) NOT NULL,
  `portion_id` enum('1','2','4','8','Z') NOT NULL,
  `power_type` enum('D','DEM','DMU','E','ED','EML','EMU','EPU','HST','LDS') DEFAULT NULL,
  `timing_load` varchar(4) DEFAULT NULL,
  `speed` varchar(3) NOT NULL,
  `operating_characteristics` varchar(6) DEFAULT NULL,
  `train_class` enum('B','S') DEFAULT NULL,
  `sleepers` enum('B','S','F') DEFAULT NULL,
  `reservations` enum('A','R','S','E') DEFAULT NULL,
  `catering_code` varchar(4) DEFAULT NULL,
  `service_branding` varchar(4) NOT NULL,
  `stp_indicator` enum('P','N','O') NOT NULL,
  `uic_code` varchar(5) NOT NULL,
  `atoc_code` varchar(2) NOT NULL,
  `ats_code` enum('Y','N') NOT NULL,
  `rsid` varchar(8) NOT NULL,
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11973 ;

-- --------------------------------------------------------

--
-- Table structure for table `td_feed`
--

CREATE TABLE IF NOT EXISTS `td_feed` (
  `to_loc` text,
  `time` datetime DEFAULT NULL,
  `area_id` text,
  `msg_type` text,
  `from_loc` text,
  `descr` text,
  `report_time` text
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
