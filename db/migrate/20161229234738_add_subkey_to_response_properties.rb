class AddSubkeyToResponseProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :response_properties, :subkey, :string
  end
end
