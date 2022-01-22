class AddForeignKeyToTables < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :notes, :users
    add_foreign_key :labels, :users
    add_foreign_key :labelings, :notes
    add_foreign_key :labelings, :labels
  end
end
