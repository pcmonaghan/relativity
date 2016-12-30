class AddSubkeyToFieldKeys < ActiveRecord::Migration[5.0]
  def change
    add_column :field_keys, :subkey, :string
  end
end
