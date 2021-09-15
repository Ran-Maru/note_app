class RemoveNoteIdFromNotes < ActiveRecord::Migration[6.0]
  def change
    remove_column :notes, :note_id, :string
  end
end
