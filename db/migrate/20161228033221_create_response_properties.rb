class CreateResponseProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :response_properties do |t|
      t.string :form_id
      t.string :record_id
      t.string :key_num
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
