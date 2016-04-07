class AddColumnSynchronizationsSynchAt < ActiveRecord::Migration[5.0]
  def change
    add_column :synchronizations, :sync_at, :datetime
    rename_column :synchronizations, :cartodb_id, :sync_id
  end
end
