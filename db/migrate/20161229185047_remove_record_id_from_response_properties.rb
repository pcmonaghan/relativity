class RemoveRecordIdFromResponseProperties < ActiveRecord::Migration[5.0]
  def change
    remove_column :response_properties, :record_id 
  end
end
