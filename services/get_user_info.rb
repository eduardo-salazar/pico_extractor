require 'json'
module DataExtraction

  def self.get_user_info(object)

      user = User.new
      puts "Extracting from user_info"

      cbid = object["user_dim"]["user_properties"].select {|prop| prop["key"] == "cbid" }
      begin
        user.cbid = cbid[0]["value"]["value"]["string_value"]
      rescue
        user.cbid = ""
      end

      user.first_open_timestamp = object["user_dim"]["first_open_timestamp_micros"]
      
      user
  end

end
