require 'json'
module DataExtraction

  def self.get_app_info(object)

      app = App.new
      puts "Extracting from app_info"
      app.id = object["user_dim"]["app_info"]["app_id"]
      app.version = object["user_dim"]["app_info"]["app_version"]
      app.instance_id =object["user_dim"]["app_info"]["app_instance_id"]
      app.store =object["user_dim"]["app_info"]["app_store"]
      app.platform =object["user_dim"]["app_info"]["app_platform"]

      app
  end

end
