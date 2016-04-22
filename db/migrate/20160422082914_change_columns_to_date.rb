class ChangeColumnsToDate < ActiveRecord::Migration[5.0]
  def change
    remove_column :value_objects, :as_of_dt
    remove_column :value_objects, :created_dt
    add_column :value_objects, :as_of_dt, :date
    add_column :value_objects, :created_dt, :date
  end
end
