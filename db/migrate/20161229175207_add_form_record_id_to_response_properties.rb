class AddFormRecordIdToResponseProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :response_properties, :form_record_id, :string
  end
end
