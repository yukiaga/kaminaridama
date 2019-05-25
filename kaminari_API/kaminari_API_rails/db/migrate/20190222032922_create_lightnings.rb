class CreateLightnings < ActiveRecord::Migration[5.2]
  def change
    create_table :lightnings do |t|
      t.string :flash_lat
      t.string :flash_lon
      t.string :year
      t.string :month
      t.string :day
      t.string :hour
      t.string :minute
      t.string :second
      t.string :decimal_number
      t.string :flash_time
      t.string :date_time

      t.timestamps
    end
      add_index :lightnings, :date_time, unique: true
  end
end
