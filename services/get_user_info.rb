require 'json'
module DataExtraction

  def self.get_user_info(object)

      user = User.new
      #puts "Extracting from user_info"

      cbid = object["user_dim"]["user_properties"].select {|prop| prop["key"] == "cbid" }
      user.cbid = cbid[0]["value"]["value"]["string_value"] rescue ""

      user.first_open_timestamp = object["user_dim"]["first_open_timestamp_micros"] rescue ""

      user
  end

end
