class RenameKeyNumToSubkeyNumInFieldKeys < ActiveRecord::Migration[5.0]
  def change
    rename_column :field_keys, :key_num, :subkey_num
  end
end
