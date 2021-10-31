class AddColumnIsArchived < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :is_archived, :boolean, {null: false, default: false}
  end
end
