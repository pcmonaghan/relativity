class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.string :integration
      t.integer :num_records

      t.timestamps
    end
  end
end
