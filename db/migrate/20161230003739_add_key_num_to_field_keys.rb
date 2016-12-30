class AddKeyNumToFieldKeys < ActiveRecord::Migration[5.0]
  def change
    add_column :field_keys, :key_num, :string
  end
end
