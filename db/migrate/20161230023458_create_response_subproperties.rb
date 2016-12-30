class CreateResponseSubproperties < ActiveRecord::Migration[5.0]
  def change
    create_table :response_subproperties do |t|
      t.belongs_to :response_property, index: true
      t.string :subkey_num
      t.string :subkey
      t.string :value

      t.timestamps
    end
  end
end
