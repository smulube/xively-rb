module PachubeDataFormats
  module Parsers
    module FeedDefaults
      def from_json(json)
        hash = JSON.parse(json)
        case hash['version']
        when '1.0.0'
          transform_1_0_0(hash)
        when '0.6-alpha'
          transform_0_6_alpha(hash)
        end
      end

      private

      def transform_1_0_0(hash)
        hash["updated"] = hash["updated"]
        hash["status"] = hash["status"]
        hash["datastreams"] = hash["datastreams"].collect do |datastream|
          unit_hash = {}
          if unit = datastream.delete('unit')
            unit_hash['unit_type'] = unit['type']
            unit_hash['unit_symbol'] = unit['symbol']
            unit_hash['unit_label'] = unit['label']
          end
          {
            "id" => datastream["id"],
            "current_value" => datastream["current_value"],
            "min_value" => datastream["min_value"],
            "max_value" => datastream["max_value"],
            "updated" => datastream["at"],
            "tags" => datastream["tags"].join(','),
          }.merge(unit_hash)
        end
        if location = hash.delete("location")
          hash["location_disposition"] = location["disposition"]
          hash["location_domain"] = location["domain"]
          hash["location_ele"] = location["ele"]
          hash["location_exposure"] = location["exposure"]
          hash["location_lat"] = location["lat"]
          hash["location_lon"] = location["lon"]
          hash["location_name"] = location["name"]
        end
        hash
      end

      def transform_0_6_alpha(hash)
        hash["retrieved_at"] = hash["updated"]
        hash["state"] = hash["status"]
        hash["datastreams"] = hash["datastreams"].collect do |datastream|
          unit_hash = {}
          if unit = datastream.delete('unit')
            unit_hash['unit_type'] = unit['type']
            unit_hash['unit_symbol'] = unit['symbol']
            unit_hash['unit_label'] = unit['label']
          end
          {
            "id" => datastream["id"],
            "current_value" => datastream["values"].first["value"],
            "min_value" => datastream["values"].first["min_value"],
            "max_value" => datastream["values"].first["max_value"],
            "updated" => datastream["values"].first["recorded_at"],
            "tags" => datastream["tags"].join(','),
          }.merge(unit_hash)
        end
        if location = hash.delete("location")
          hash["location_disposition"] = location["disposition"]
          hash["location_domain"] = location["domain"]
          hash["location_ele"] = location["ele"]
          hash["location_exposure"] = location["exposure"]
          hash["location_lat"] = location["lat"]
          hash["location_lon"] = location["lon"]
          hash["location_name"] = location["name"]
        end
        hash
      end

    end
  end
end

