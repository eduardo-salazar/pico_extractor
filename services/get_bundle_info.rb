require 'json'
module DataExtraction

  def self.get_bundle_info(object)

      bundle = BundleInfo.new
      puts "Extracting from bundle_info"

      bundle.bundle_sequence_id = object["user_dim"]["bundle_info"]["bundle_sequence_id"]
      bundle.server_timestamp_offset_micros = object["user_dim"]["bundle_info"]["server_timestamp_offset_micros"]

      bundle
  end

end
