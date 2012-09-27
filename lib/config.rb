require 'json'

module Tinker
  class Config
    class << self
      def init
        if File.exists? 'config/config.json'
          begin
            @config = JSON.parse File.open('config/config.json', 'rb').read
          rescue JSON::ParserError => e
            p "Failed to parse config file"
          end
        else
          p "No config file found"
        end
      end

      def [] key
        @config[key] || nil
      end
    end
  end
end

