require 'open-uri'
require 'zlib'

module DataExtraction
    def self.download_file(url)
        puts "File is downloading: #{url}"
        begin
            download = open(url.strip)
            gz = Zlib::GzipReader.new(download)
            result = gz.read
            File.write('temp_data.json', result)
        rescue Exception => e
            puts "An error occured!"
            print e.message
            return false
        end
        puts "Download Finished"
        true
    end

    def self.remove_file(file_path)
        puts "Deleting file #{file_path}"
        File.delete(file_path)
        puts "Removed file"
    end

    def self.read_links_file(path, line_nums)

        File.open(path, 'r') do |f|
            f.each_line.with_index do |line, index|
                if(line_nums.include? index)
                    yield(line)
                end
            end
          end
    end

    def self.save_json_file(data, name)
        puts "Saving file to #{name}.json..."
        filename = "#{name}.json"
        if File.file?(filename)
            json = File.read(filename)
            existing_data = JSON.parse(json)
            existing_data << data

            File.write(filename,existing_data.to_json)
            puts "Appended data to existing file."
        else
            File.write(filename, data.to_json)
            puts "Created new file."
        end
        puts "Saved file!"
    end

    def self.extract_input_user_dim(json_path, data, input)
        puts "Extracting #{input} from user_dim.."
        File.open(json_path, "r") do |f|
            f.each_line do |line|
                json = JSON.parse(line)

                data << json["user_dim"][input]

            end

            puts "Finished extracting!"

        end
    end


end
