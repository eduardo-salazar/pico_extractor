require 'uri'
require 'app_configuration'
require_relative 'services/init.rb'
require_relative 'models/init.rb'
require 'securerandom'

config = AppConfiguration.new

###############################################################################
# Get Links
links = DataExtraction::get_links(config["cardinalblue_ios_file"])
total_links = links.size
links.each_with_index do |link,index|
    puts "#{index+1} of #{links.size}: Downloading file #{link}"
    # Download File and save it (saved to temp_data.json)
    destination = DataExtraction::download_file(link, destination:config["export_directory"])
end