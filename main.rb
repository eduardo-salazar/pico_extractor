require 'uri'
require 'app_configuration'
require_relative 'services/init.rb'
require_relative 'models/init.rb'

config = AppConfiguration.new

# Get Links
links = DataExtraction::get_links(config["cardinalblue_ios_file"],sample:1)

links.each do |link|
  # Download File and save it (saved to temp_data.json)
  destination = DataExtraction::download_file(link, destination:config["export_directory"])


  File.open(destination, "r") do |f|
      f.each_line do |line|
          json = JSON.parse(line)
          puts JSON.generate(json)

          user = DataExtraction::get_user_info(json)
          app = DataExtraction::get_app_info(json)
          dev = DataExtraction::get_device_info(json)


          # User information
          puts user.cbid
          puts user.first_open_timestamp
          puts app.id
          puts app.version
          puts app.instance_id
          puts app.store
          puts app.platform
          puts dev.category
          puts dev.model
          puts dev.platform_version
          puts dev.user_default_language
          puts dev.time_zone_offset_seconds
          puts dev.limited_ad_tracking

          break


      end

      puts "Finished extracting!"

  end


  #  DataExtraction::extract_input_user_dim("temp_data.json", data, input)

  #  DataExtraction::save_json_file(data, input)

  #  DataExtraction.remove_file("temp_data.json")

  puts "Saved to #{destination}"

end
