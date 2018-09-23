# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_21_125250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "external_apis", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "last_called_at"
    t.integer "seconds_between_calls", default: 1, null: false
    t.index ["name"], name: "index_external_apis_on_name"
  end

  create_table "weather_forecasts", force: :cascade do |t|
    t.integer "city_id", null: false
    t.string "city_name"
    t.jsonb "weather_data", default: "{}", null: false
    t.index ["city_id"], name: "index_weather_forecasts_on_city_id"
    t.index ["weather_data"], name: "index_weather_forecasts_on_weather_data", using: :gin
  end

end
