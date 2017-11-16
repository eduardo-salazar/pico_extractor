require 'json'
module DataExtraction

  def self.get_device_info(object)

      dev = Device.new
      #puts "Extracting from device_info"

      dev.category = object["user_dim"]["device_info"]["device_category"] rescue ""
      dev.model = object["user_dim"]["device_info"]["device_model"] rescue ""
      dev.platform_version = object["user_dim"]["device_info"]["platform_version"] rescue ""
      dev.user_default_language = object["user_dim"]["device_info"]["user_default_language"] rescue ""
      dev.time_zone_offset_seconds = object["user_dim"]["device_info"]["device_time_zone_offset_seconds"] rescue ""
      dev.limited_ad_tracking = object["user_dim"]["device_info"]["limited_ad_tracking"] rescue ""

      dev
  end

end
