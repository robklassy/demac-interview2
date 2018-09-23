module ExternalApi
  class OpenWeatherMap < Base

    class << self

      def api_key
        'c8ebf038ef392b89eb2c911167e4cae1'
      end

      def api_name
        'openweathermap'
      end

      def seconds_between_calls
        600
      end

      def base_url
        'https://api.openweathermap.org/data/2.5/forecast'
      end

      def get_weather_data(options={})
        city_id = options[:city_id]
        api = ExternalApi::OpenWeatherMap.where(name: api_name, seconds_between_calls: seconds_between_calls).first_or_create!

        if api.last_called_at.blank?
          api.update_attribute(:last_called_at, Time.zone.now - seconds_between_calls)
        end

        if (Time.zone.now - api.last_called_at).seconds > api.seconds_between_calls
          response = HTTParty.get("#{base_url}?id=#{city_id}&appid=#{api_key}")
          api.update_attribute(:last_called_at, Time.zone.now)
          return JSON.parse(response.body)
        end

        nil
      end

    end
  end
end

