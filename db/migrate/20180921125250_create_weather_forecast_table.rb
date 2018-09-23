class CreateWeatherForecastTable < ActiveRecord::Migration[5.2]
  def up
    create_table :weather_forecasts do |t|
      t.integer :city_id, null: false
      t.string :city_name
      t.jsonb :weather_data, null: false, default: '{}'
    end

    add_index :weather_forecasts, :weather_data, using: :gin
    add_index :weather_forecasts, :city_id
  end

  def down
    drop_table :weather_forecasts
  end
end
