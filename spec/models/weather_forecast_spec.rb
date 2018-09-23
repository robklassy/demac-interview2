require 'rails_helper'

RSpec.describe WeatherForecast, :type => :model do
  before(:all) do
    WeatherForecast.delete_all
  end

  describe 'wear_jacket?' do
    it 'returns false when temps are above any jacket required' do
      data1_path = "#{Rails.root.to_s}/spec/models/data/data1.json"
      weather_data = JSON.parse(File.open(data1_path, 'r').read)
      wf = WeatherForecast.create!(city_id: 123, city_name: 'Los Santos', weather_data: weather_data)
      expect(wf.wear_jacket?).to be_falsey
    end

    it 'returns true when weather data has below min jacket temps' do
      data2_path = "#{Rails.root.to_s}/spec/models/data/data2.json"
      weather_data = JSON.parse(File.open(data2_path, 'r').read)
      wf = WeatherForecast.create!(city_id: 123, city_name: 'Liberty City', weather_data: weather_data)
      expect(wf.wear_jacket?).to be_truthy
    end

    it 'returns false when temps are too high for jackets but wind is very high' do
      data3_path = "#{Rails.root.to_s}/spec/models/data/data3.json"
      weather_data = JSON.parse(File.open(data3_path, 'r').read)
      wf = WeatherForecast.create!(city_id: 123, city_name: 'Vice City', weather_data: weather_data)
      expect(wf.wear_jacket?).to be_falsey
    end

    it 'returns true when temps are lower (but above automatic jacket level) but wind is very high' do
      data4_path = "#{Rails.root.to_s}/spec/models/data/data4.json"
      weather_data = JSON.parse(File.open(data4_path, 'r').read)
      wf = WeatherForecast.create!(city_id: 123, city_name: 'Las Venturas', weather_data: weather_data)
      expect(wf.wear_jacket?).to be_truthy
    end

    it 'returns false when temps are between min and max jacket temps with moderate winds' do
      data5_path = "#{Rails.root.to_s}/spec/models/data/data5.json"
      weather_data = JSON.parse(File.open(data5_path, 'r').read)
      wf = WeatherForecast.create!(city_id: 123, city_name: 'Carcer City', weather_data: weather_data)
      expect(wf.wear_jacket?).to be_falsey
    end
  end
end