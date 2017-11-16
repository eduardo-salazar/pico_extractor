require 'open-uri'
require 'zlib'

module DataExtraction

  def self.download_file(url,destination:"/")
      #puts "File is downloading: #{url}"
      begin
          download = open(url.strip)
          name = url.split("/").last.split(".").first
          file_path = "#{destination}/#{name}.json"
          gz = Zlib::GzipReader.new(download)
          result = gz.read

          File.write("#{file_path}", result)

          "#{file_path}"
      rescue Exception => e
          puts "An error occured!"
          print e.message
          return ""
      end
  end

end
