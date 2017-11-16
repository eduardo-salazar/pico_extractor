require 'json'
module DataExtraction

  def self.get_events_info(object)

      events = Array.new
      puts "Extracting from events_dim"

      object["event_dim"].each do |event|

        new_event = Event.new
        new_event.name = event["name"] rescue ""
        new_event.date = event["date"] rescue ""
        new_event.timestamp_micros = event["timestamp_micros"] rescue ""
        new_event.previous_timestamp_micros = event["previous_timestamp_micros"] rescue ""

        events.push(new_event)

      end

      events
  end

end
