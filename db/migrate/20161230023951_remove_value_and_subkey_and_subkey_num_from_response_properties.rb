class RemoveValueAndSubkeyAndSubkeyNumFromResponseProperties < ActiveRecord::Migration[5.0]
  def change
    remove_column :response_properties, :subkey
    remove_column :response_properties, :subkey_num
    remove_column :response_properties, :value
  end
end
