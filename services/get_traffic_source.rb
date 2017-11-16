require 'json'
module DataExtraction

  def self.get_traffic_source(object)

      ts = TrafficSource.new
      puts "Extracting from traffic_source"

      ts.user_acquired_campaign = object["user_dim"]["traffic_source"]["user_acquired_campaign"] rescue ""
      ts.user_acquired_source = object["user_dim"]["traffic_source"]["user_acquired_source"] rescue ""
      ts.user_acquired_medium = object["user_dim"]["traffic_source"]["user_acquired_medium"] rescue ""

      ts
  end

end
