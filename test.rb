#!/usr/bin/env ruby

require_relative 'data_extraction.rb'
require_relative 'json_to_csv.rb'

=begin
if ARGV[0] && ARGV[0] != "" && ARGV[1] && ARGV[1] != ""

else
    puts "Usage : json_batch_convert.rb <json url list file path> <csv out file path>"
end
=end
#test url to gz file.
url = ""
#DataExtraction::download_file(url)
=begin
if(DataExtraction::download_file(url))
    JsonToCsvConverter::json_file_to_csv_file('temp_data.json', 'data.csv')
else
    puts "File download unsuccessful for: #{url}"
end
=end

JsonToCsvConverter::json_file_to_csv_file('temp_data.json', 'data.csv')