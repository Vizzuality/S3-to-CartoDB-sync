class ChangeIndicatorsToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :value_objects, :current_val, :float
    change_column :value_objects, :previous_val, :float
    change_column :value_objects, :current_fytd, :float
    change_column :value_objects, :previous_fytd, :float
    change_column :value_objects, :previous_year_period, :float
  end
end
