require 'uri'
require 'app_configuration'
require_relative 'services/init.rb'
require_relative 'models/init.rb'

config = AppConfiguration.new

#Create Empty export files
csv_user_path = config["export_directory"] + "/user_info.csv"
csv_events_path = config["export_directory"] + "/events_info.csv"
csv_summary_path = config["export_directory"] + "/summary.csv"
DataExtraction::csv_create(csv_user_path,[
  "source",
  "cbid",
  "first_open_timestamp",
  "app_id",
  "app_version",
  "app_instance_id",
  "app_store",
  "app_platform",
  "device_category",
  "device_model",
  "device_platform_version",
  "device_user_default_language",
  "device_time_zone_offset_seconds",
  "device_limited_ad_tracking",
  "geo_continent",
  "geo_country",
  "geo_region",
  "traffic_source_user_acquired_campaign",
  "traffic_source_user_acquired_source",
  "traffic_source_user_acquired_medium",
  "bundle_sequence_id",
  "bundleserver_timestamp_offset_micros",
  "num_events"
])

DataExtraction::csv_create(csv_events_path,[
  "source",
  "cbid",
  "app_instance_id",
  "event_name",
  "event_date",
  "event_timestamp_micros",
  "event_previous_timestamp_micros"
])

DataExtraction::csv_create(csv_summary_path,[
  "description","total","sample","size"
])
###############################################################################
# Get Links
links = DataExtraction::get_links(config["cardinalblue_ios_file"])
total_links = links.size
links = DataExtraction::sample_links(links,sample:config["links_sample"])
DataExtraction::csv_add_line(csv_summary_path,[
  "Links",total_links,config["links_sample"],links.size
])

links.each_with_index do |link,index|
  puts "#{index+1} of #{links.size}: Downloading file #{link}"
  # Download File and save it (saved to temp_data.json)
  destination = DataExtraction::download_file(link, destination:config["export_directory"])
  file_name = destination.split("/").last.split(".").first

  i = 0
  link_lines_count = `wc -l "#{destination}"`.strip.split(' ')[0].to_i
  puts "Total lines #{link_lines_count}"

  #Calculate sample for link
  sample_size = (link_lines_count.to_f * config["records_sample"].to_f).ceil
  # Save in csv_summary_path
  DataExtraction::csv_add_line(csv_summary_path,[
    file_name,link_lines_count,config["records_sample"],sample_size
  ])

  File.readlines(destination).sample(sample_size).each do |line|

      i += 1
      puts " Link #{index+1} of #{links.size} | Processing object #{i}"
      json = JSON.parse(line)

      # Getting information
      user = DataExtraction::get_user_info(json)
      app = DataExtraction::get_app_info(json)
      dev = DataExtraction::get_device_info(json)
      geo = DataExtraction::get_geo_info(json)
      ts = DataExtraction::get_traffic_source(json)
      bundle = DataExtraction::get_bundle_info(json)
      events = DataExtraction::get_events_info(json)


      #Exporting info of users
      DataExtraction::csv_add_line(csv_user_path,[
        file_name,
        user.cbid,
        user.first_open_timestamp,
        app.id,
        app.version,
        app.instance_id,
        app.store,
        app.platform,
        dev.category,
        dev.model,
        dev.platform_version,
        dev.user_default_language,
        dev.time_zone_offset_seconds,
        dev.limited_ad_tracking,
        geo.continent,
        geo.country,
        geo.region,
        ts.user_acquired_campaign,
        ts.user_acquired_source,
        ts.user_acquired_medium,
        bundle.bundle_sequence_id,
        bundle.server_timestamp_offset_micros,
        events.size
      ])

      #Exporting info of Events
      events.each do |event|
        DataExtraction::csv_add_line(csv_events_path,[
          file_name,
          user.cbid,
          app.instance_id,
          event.name,
          event.date,
          event.timestamp_micros,
          event.previous_timestamp_micros
        ])
      end
  end
  DataExtraction::delete_file(destination)

end
