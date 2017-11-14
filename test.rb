#!/usr/bin/env ruby

require_relative 'test_load_all.rb'
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

#JsonToCsvConverter::json_file_to_csv_file('temp_data.json', 'data.csv')

DataExtraction::read_links_file("../ios_events.txt", [2]){ |url|
    inputs = ["device_info"]

    if(DataExtraction::download_file(url))
        inputs.each do |input|
            data = []
            DataExtraction::extract_input_user_dim("temp_data.json", data, input)
            DataExtraction::save_json_file(data, input)
            
    
        end

        DataExtraction.remove_file("temp_data.json")
    
        puts "Finished with #{url}"
    end

    
}