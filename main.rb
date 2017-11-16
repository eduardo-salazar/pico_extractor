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
  file_name = destination.split("/").last.split(".").first


  File.open(destination, "r") do |f|
      f.each_line do |line|
          json = JSON.parse(line)
          puts JSON.generate(json)

          user = DataExtraction::get_user_info(json)
          app = DataExtraction::get_app_info(json)
          dev = DataExtraction::get_device_info(json)
          geo = DataExtraction::get_geo_info(json)
          ts = DataExtraction::get_traffic_source(json)
          bundle = DataExtraction::get_bundle_info(json)
          events = DataExtraction::get_events_info(json)


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
          puts geo.continent
          puts geo.country
          puts geo.region
          puts ts.user_acquired_campaign
          puts ts.user_acquired_source
          puts ts.user_acquired_medium
          puts bundle.bundle_sequence_id
          puts bundle.server_timestamp_offset_micros

          puts "Events"
          events.each do |event|
            puts ""
            puts event.name
            puts event.date
            puts event.timestamp_micros
            puts event.previous_timestamp_micros
          end

          puts file_name

          break


      end

      puts "Finished extracting!"

  end


  #  DataExtraction::extract_input_user_dim("temp_data.json", data, input)

  #  DataExtraction::save_json_file(data, input)

  #  DataExtraction.remove_file("temp_data.json")

  puts "Saved to #{destination}"

end
