class AddSubkeyNumToResponseProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :response_properties, :subkey_num, :string
  end
end
