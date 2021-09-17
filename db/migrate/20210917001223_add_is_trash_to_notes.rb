class AddIsTrashToNotes < ActiveRecord::Migration[6.0]
  def change
    # default:falseにする。
    add_column :notes, :isTrash, :boolean, {null: false, default: false}
  end
end
