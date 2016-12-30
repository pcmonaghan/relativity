class AddIntegrationAndRecordIdToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :record_id, :string
    add_column :responses, :integration, :string
  end
end
