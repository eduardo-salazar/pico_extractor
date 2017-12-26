require 'uri'
require 'app_configuration'
require_relative 'services/init.rb'
require_relative 'models/init.rb'
require 'securerandom'

config = AppConfiguration.new

# Create connection and create squema
db = DataExtraction::DbClient.new(config["mysql_host"],config["mysql_username"],config["mysql_password"])
db.run_query("create_schema")

# Check file with users id
id_of_users = CSV.read(config["target_users_path"])
if id_of_users.size > 0 
  unique_user = id_of_users
else
  unique_user = []
end

# Database Picollage
# Tables:
#   events_info
#   user_info
#   summary_info

###############################################################################
# Get Links
links = DataExtraction::get_links(config["cardinalblue_ios_file"])
total_links = links.size
links = DataExtraction::sample_links(links,sample:config["links_sample"])

links.each_with_index do |link,index|
  
  # Get file json file name
  file_name = link.split("/").last.split(".").first + ".json"
  destination = config["export_directory"]+"/#{file_name}"

  puts "Checking if #{destination} exists"
  if !File.exists?(destination)
    puts "#{index+1} of #{links.size}: Downloading file #{link}"
    # Download File and save it (saved to temp_data.json)
    destination = DataExtraction::download_file(link, destination:config["export_directory"])
  end
  puts "#{index+1} of #{links.size}: Reading file #{link}"
  i = 0
  link_lines_count = `wc -l "#{destination}"`.strip.split(' ')[0].to_i
  puts "Total lines #{link_lines_count}"

  #Calculate sample for link
  sample_size = (link_lines_count.to_f * config["records_sample"].to_f).ceil

  #skip = 5000
  File.readlines(destination).sample(sample_size).each do |line|
      random_id = SecureRandom.hex
      i += 1
      #if i == skip
      #  puts "Link #{index+1} of #{links.size} | Processing object #{i} of #{sample_size}"
      #  skip = skip + 5000
      #end 
      json = JSON.parse(line)

      # Getting information
      app = DataExtraction::get_app_info(json)

      # This if is when unique user array reach limit of users to search
      # No new app instances i allowed
      if(config["total_users"].to_i == unique_user.size.to_i)
        # If app instance id is not in list then go to next
        if(!unique_user.include?(app.instance_id.to_s.strip))
          next
        end
      else
        unique_user.push(app.instance_id.to_s.strip) if(!unique_user.include?(app.instance_id.to_s.strip))
      end

      # Getting rest of information
      puts "Link #{index+1} of #{links.size} | object #{i} of #{sample_size} | Extracting info of user #{app.instance_id}"
      user = DataExtraction::get_user_info(json)
      dev = DataExtraction::get_device_info(json)
      geo = DataExtraction::get_geo_info(json)
      ts = DataExtraction::get_traffic_source(json)
      bundle = DataExtraction::get_bundle_info(json)
      events = DataExtraction::get_events_info(json)


      #Exporting info of users
      db.insert_into("user_info",[
        random_id.to_s,
        file_name.to_s,
        user.cbid.to_s,
        user.first_open_timestamp.to_s,
        app.id.to_s,
        app.version.to_s,
        app.instance_id.to_s.strip,
        app.store.to_s,
        app.platform.to_s,
        dev.category.to_s,
        dev.model.to_s,
        dev.platform_version.to_s,
        dev.user_default_language.to_s,
        dev.time_zone_offset_seconds.to_i,
        dev.limited_ad_tracking.to_s,
        geo.continent.to_s,
        geo.country.to_s,
        geo.region.to_s,
        bundle.bundle_sequence_id.to_i,
        bundle.server_timestamp_offset_micros.to_s,
        events.size.to_i
      ])

      #Exporting info of Events
      events.each do |event|
        db.insert_into("events_info",[
          random_id.to_s,
          app.instance_id.to_s.strip,
          event.name.to_s,
          Date.strptime(event.date, '%Y%m%d').strftime('%Y-%m-%d %H:%M:%S'),
          event.timestamp_micros,
          event.previous_timestamp_micros.to_s,
          event.type.to_s,
          event.purchase_events.product_id.to_s,
          event.purchase_events.device_id.to_s,
          event.category.to_s,
          event.font_name.to_s,
          event.product_name.to_s,
          event.collage_style.to_s,
          event.background_type.to_s,
          event.num_of_doodle.to_i,
          event.num_of_image_scraps.to_i,
          event.num_of_texts.to_i,
          event.num_of_stickers.to_i,
          event.from.to_s,
          event.number_of_image.to_i,
          event.stroke_count.to_i,
          event.number.to_s,
          event.category_name.to_s
        ])
      end
  end
end
