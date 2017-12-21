CREATE DATABASE  IF NOT EXISTS `PicCollage`;
USE `PicCollage`;
DROP TABLE IF EXISTS `events_info`;
CREATE TABLE `events_info` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) DEFAULT NULL,
  `app_instance_id` varchar(255) DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `event_timestamp_micros` bigint(11) DEFAULT NULL,
  `event_previous_timestamp_micros` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `font_name` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `collage_style` varchar(255) DEFAULT NULL,
  `background_type` varchar(255) DEFAULT NULL,
  `num_of_doodle` int(255) DEFAULT NULL,
  `num_of_image_scraps` int(255) DEFAULT NULL,
  `num_of_texts` int(255) DEFAULT NULL,
  `num_of_stickers` int(255) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `number_of_image` int(255) DEFAULT NULL,
  `stroke_count` int(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `Indexes` (`app_instance_id`,`event_name`,`event_timestamp_micros`,`event_previous_timestamp_micros`,`session_id`,`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1125087 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `session_id` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `cbid` varchar(255) DEFAULT NULL,
  `first_open_timestamp` varchar(255) DEFAULT NULL,
  `app_id` varchar(255) DEFAULT NULL,
  `app_version` varchar(255) DEFAULT NULL,
  `app_instance_id` varchar(255) DEFAULT NULL,
  `app_store` varchar(255) DEFAULT NULL,
  `app_platform` varchar(255) DEFAULT NULL,
  `device_category` varchar(255) DEFAULT NULL,
  `device_model` varchar(255) DEFAULT NULL,
  `device_platform_version` varchar(255) DEFAULT NULL,
  `device_user_default_language` varchar(255) DEFAULT NULL,
  `device_time_zone_offset_seconds` int(255) DEFAULT NULL,
  `device_limited_ad_tracking` varchar(255) DEFAULT NULL,
  `geo_continent` varchar(255) DEFAULT NULL,
  `geo_country` varchar(255) DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `bundle_sequence_id` int(255) DEFAULT NULL,
  `bundleserver_timestamp_offset_micros` bigint(255) DEFAULT NULL,
  `num_events` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `summary_info`;
CREATE TABLE `summary_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `total` int(255) DEFAULT NULL,
  `sample` int(255) DEFAULT NULL,
  `size` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Indexes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1125087 DEFAULT CHARSET=utf8;

