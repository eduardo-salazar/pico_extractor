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

        new_event.purchase_events = purchase

        events.push(new_event)

      end

      events
  end

end
