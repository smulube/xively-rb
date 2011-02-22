module PachubeDataFormats
  module Formats
    module Datastreams
      class JSON < Base
        def self.parse(input)
          hash = ::JSON.parse(input)
          hash['retrieved_at'] = hash.delete('at')
          hash['value'] = hash.delete('current_value')
          hash['tag_list'] = hash.delete('tags').join(',')
          if unit = hash.delete('unit')
            hash['unit_type'] = unit['type']
            hash['unit_symbol'] = unit['symbol']
            hash['unit_label'] = unit['label']
          end
          return hash
        end

        def self.generate(hash)
          case hash["version"]
          when "0.6-alpha"
            hash['values'] = {
              'recorded_at' => hash.delete('retrieved_at'),
              'value' => hash.delete('value'),
              'max_value' => hash.delete('max_value'),
              'min_value' => hash.delete('min_value')
            }
            hash['tags'] = hash.delete('tag_list').split(',').map(&:strip).sort if hash['tag_list']
            if hash['unit_type'] || hash['unit_symbol'] || hash['unit_label']
              hash['unit'] = {
                'type' => hash.delete('unit_type'),
                'symbol' => hash.delete('unit_symbol'),
                'label' => hash.delete('unit_label')
              } 
            end
          else # "1.0.0"
            hash['at'] = hash.delete('retrieved_at') if hash['retrieved_at']
            hash['current_value'] = hash.delete('value')
            hash['tags'] = hash.delete('tag_list').split(',').map(&:strip).sort if hash['tag_list']
            if hash['unit_type'] || hash['unit_symbol'] || hash['unit_label']
              hash['unit'] = {
                'type' => hash.delete('unit_type'),
                'symbol' => hash.delete('unit_symbol'),
                'label' => hash.delete('unit_label')
              } 
            end
          end
          hash.delete("version")
          hash
        end
      end
    end
  end
end
