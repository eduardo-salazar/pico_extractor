require 'open-uri'
require 'zlib'

module DataExtraction
    def self.download_file(url)
        puts "File is downloading: #{url}"
        begin
            download = open(url)
            gz = Zlib::GzipReader.new(download) 
            result = gz.read
            File.write('temp_data.json', result)
        rescue Exception => e
            puts "An error occured!"
            return false
        end
        puts "Download Finished for: #{url}"
        true
    end

    def self.remove_file(file_path)
        File.delete(file_path)
    end
end