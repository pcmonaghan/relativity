class FixResponseRecordIdName < ActiveRecord::Migration[5.0]
  def change
    rename_column :responses, :record_id, :form_record_id
  end
end
