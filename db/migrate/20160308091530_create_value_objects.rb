class CreateValueObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :value_objects do |t|
      t.string :data_set_name
      t.string :as_of_dt
      t.string :geo_type
      t.string :created_dt
      t.integer :geo_id
      t.integer :current_val
      t.integer :previous_val
      t.integer :current_fytd
      t.integer :previous_fytd
      t.integer :previous_year_period
      t.string :uid, unique: true

      t.timestamps
    end
  end
end
