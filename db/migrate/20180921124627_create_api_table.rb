class CreateApiTable < ActiveRecord::Migration[5.2]
  def up
    create_table :external_apis do |t|
      t.string :name, null: false
      t.datetime :last_called_at
      t.integer :seconds_between_calls, null: false, default: 1
    end

    add_index :external_apis, :name
  end

  def down
    drop_table :external_apis
  end
end
