require 'json'
module DataExtraction

  def self.get_geo_info(object)

      geo = GeoInfo.new
      puts "Extracting from geo_info"

      geo.continent = object["user_dim"]["geo_info"]["continent"]
      geo.country = object["user_dim"]["geo_info"]["country"]
      geo.region = object["user_dim"]["geo_info"]["region"]

      geo
  end

end
