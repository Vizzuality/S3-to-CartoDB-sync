class AddUniqueIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :value_objects, :uid, unique: true
  end
end
