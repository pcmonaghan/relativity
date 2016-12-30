class CreateFieldKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :field_keys do |t|
      t.string :form_id
      t.string :key_num
      t.string :key

      t.timestamps
    end
  end
end
