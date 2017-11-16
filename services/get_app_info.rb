require 'json'
module DataExtraction

  def self.get_app_info(object)

      app = App.new
      puts "Extracting from app_info"
      app.id = object["user_dim"]["app_info"]["app_id"] rescue ""
      app.version = object["user_dim"]["app_info"]["app_version"] rescue ""
      app.instance_id =object["user_dim"]["app_info"]["app_instance_id"] rescue ""
      app.store =object["user_dim"]["app_info"]["app_store"] rescue ""
      app.platform =object["user_dim"]["app_info"]["app_platform"] rescue ""

      app
  end

end
