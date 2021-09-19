class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_id, :string
    change_column :users, :user_id, :string, {null: false}
  end
end
