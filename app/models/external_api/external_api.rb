module ExternalApi
  class Base < ApplicationRecord
    self.table_name = 'external_apis'

    class << self
      def get_weather_data(options={})
        raise NotImplementedError
      end

      def seconds_between_calls
        raise NotImplementedError
      end
    end

  end
end