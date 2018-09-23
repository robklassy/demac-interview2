# stores forecast data for a single city
class WeatherForecast < ApplicationRecord

  # anything above this threshold means i should wear a jacket in this city
  def minimum_jacket_threshold_points
    80
  end

  def minimum_jacket_temperature
    283.15
  end

  def maximum_jacket_temperature
    293.15
  end

  def jacket_required_wind_speed
    30.0
  end

  def update_weather_data
    data = ExternalApi::OpenWeatherMap.get_weather_data(city_id: city_id)

    if data.present?
      update_attributes!(weather_data: data)
    end
  end

  def wear_jacket?
    jacket_points =
        determine_temperature_jacket_points +
        determine_wind_jacket_points +
        determine_snow_jacket_points

    # puts jacket_points
    jacket_points > minimum_jacket_threshold_points
  end

  # get a score from what the temperature is
  def determine_temperature_jacket_points
    temp_min = weather_data['list'].first['main']['temp_min']

    if temp_min < minimum_jacket_temperature
      return minimum_jacket_threshold_points
    end

    if temp_min > minimum_jacket_temperature && temp_min < maximum_jacket_temperature
      points = (1 - (temp_min - minimum_jacket_temperature) / (maximum_jacket_temperature - minimum_jacket_temperature)) *
          minimum_jacket_threshold_points
      return points
    end

    0
  end

  # get a score for how windy it is
  def determine_wind_jacket_points
    wind_speed = weather_data['list'].first['wind']['speed']
    (wind_speed / jacket_required_wind_speed) * 40
  end

  # + 10 for a jacket if its snowing at all in the next 12 hours
  def determine_snow_jacket_points
    weather_data['list'][0..3].any? { |wd| wd['snow'].try(:keys).try(:any?) } ? 10 : 0
  end

end