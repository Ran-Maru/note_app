class CreateLabelings < ActiveRecord::Migration[6.0]
  def change
    create_table :labelings do |t|
      t.references :note
      t.references :label

      t.timestamps
    end
  end
end
