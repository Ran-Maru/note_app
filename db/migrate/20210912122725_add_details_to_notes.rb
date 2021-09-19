class AddDetailsToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :note_id, :string
    change_column :notes, :note_id, :string, {null: false}
  end
end
