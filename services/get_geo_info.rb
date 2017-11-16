require 'json'
module DataExtraction

  def self.get_geo_info(object)

      geo = GeoInfo.new
      puts "Extracting from geo_info"

      geo.continent = object["user_dim"]["geo_info"]["continent"] rescue ""
      geo.country = object["user_dim"]["geo_info"]["country"] rescue ""
      geo.region = object["user_dim"]["geo_info"]["region"] rescue ""

      geo
  end

end
