require 'json'
module DataExtraction

  def self.get_events_info(object)

      events = Array.new
      #puts "Extracting from events_dim"

      object["event_dim"].each do |event|

        new_event = Event.new
        new_event.name = event["name"] rescue ""
        type= event["params"].select {|prop| prop["key"] == "type" }
        new_event.type = type[0]["value"]["string_value"] rescue ""
        new_event.date = event["date"] rescue ""
        new_event.timestamp_micros = event["timestamp_micros"] rescue ""
        new_event.previous_timestamp_micros = event["previous_timestamp_micros"] rescue ""

        purchase = PurchaseEvent.new
        purchase.product_id = event["purchase_event"]["product_id"] rescue ""
        purchase.device_id = event["purchase_event"]["device_id"] rescue ""
        purchase.created_at = event["purchase_event"]["created_at"] rescue ""
        purchase.updated_at = event["purchase_event"]["updated_at"] rescue ""
        purchase.all = event["purchase_event"] rescue ""

        # New columns refering to Event params
        new_event.category = event["params"].select {|prop| prop["key"] == "category" }[0]["value"]["string_value"] rescue ""
        new_event.type = event["params"].select {|prop| prop["key"] == "type" }[0]["value"]["string_value"] rescue ""
        new_event.font_name = event["params"].select {|prop| prop["key"] == "font_name" }[0]["value"]["string_value"] rescue ""
        new_event.product_name = event["params"].select {|prop| prop["key"] == "product_name" }[0]["value"]["string_value"] rescue ""
        new_event.collage_style = event["params"].select {|prop| prop["key"] == "collage_style" }[0]["value"]["string_value"] rescue ""
        new_event.background_type = event["params"].select {|prop| prop["key"] == "background_type" }[0]["value"]["string_value"] rescue ""
        new_event.num_of_doodle = event["params"].select {|prop| prop["key"] == "num_of_doodle" }[0]["value"]["int_value"] rescue ""
        new_event.num_of_image_scraps = event["params"].select {|prop| prop["key"] == "num_of_image_scraps" }[0]["value"]["int_value"] rescue ""
        new_event.num_of_texts = event["params"].select {|prop| prop["key"] == "num_of_texts" }[0]["value"]["int_value"] rescue ""
        new_event.num_of_stickers = event["params"].select {|prop| prop["key"] == "num_of_stickers" }[0]["value"]["int_value"] rescue ""
        new_event.from = event["params"].select {|prop| prop["key"] == "from" }[0]["value"]["string_value"] rescue ""
        new_event.number_of_image = event["params"].select {|prop| prop["key"] == "number_of_image" }[0]["value"]["int_value"] rescue ""
        new_event.stroke_count = event["params"].select {|prop| prop["key"] == "stroke_count" }[0]["value"]["int_value"] rescue ""
        new_event.number = event["params"].select {|prop| prop["key"] == "number" }[0]["value"]["int_value"] rescue ""
        new_event.category_name = event["params"].select {|prop| prop["key"] == "category_name" }[0]["value"]["string_value"] rescue ""

        new_event.purchase_events = purchase

        events.push(new_event)

      end

      events
  end

end
