require 'json'
module DataExtraction

  def self.get_events_info(object)

      events = Array.new
      puts "Extracting from events_dim"

      object["event_dim"].each do |event|

        new_event = Event.new
        new_event.name = event["name"]
        new_event.date = event["date"]
        new_event.timestamp_micros = event["timestamp_micros"]
        new_event.previous_timestamp_micros = event["previous_timestamp_micros"]

        events.push(new_event)

      end

      events
  end

end
