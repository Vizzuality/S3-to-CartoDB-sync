class RemoveColumnSynchronizationsFileName < ActiveRecord::Migration[5.0]
  def change
    remove_column :synchronizations, :file_name
  end
end
