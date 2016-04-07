class CreateSynchronizations < ActiveRecord::Migration[5.0]
  def change
    create_table :synchronizations do |t|
      t.datetime :date
      t.string :file_name
      t.string :status
      t.string :cartodb_id
      t.text :log

      t.timestamps
    end
  end
end
