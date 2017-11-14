require 'rubygems'
require 'json'
#require 'tempfile'


module JsonToCsvConverter

	

	def self.json_file_to_csv_file(json_path, csv_path)
		puts "JSON -> CSV Conversation has started..."

		device_info = []

		File.open(json_path, "r") do |f|
			f.each_line do |line|
				json = JSON.parse(line)
				
				device_info << json["user_dim"]["device_info"]
				
			end

			File.write('device_info.json', device_info.to_json)
			puts "DONE!"
		end
	end


end
