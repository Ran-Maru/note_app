class RenamerIsTrashColumnToNotes < ActiveRecord::Migration[6.0]
  def change
    rename_column :notes, :isTrash, :is_trash
  end
end
