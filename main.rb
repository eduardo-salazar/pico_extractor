require 'uri'
require 'app_configuration'
require_relative 'services/init.rb'
require_relative 'models/init.rb'

config = AppConfiguration.new
links = DataExtraction::get_links(config["cardinalblue_ios_file"],sample:5)
