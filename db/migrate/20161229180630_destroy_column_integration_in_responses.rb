class DestroyColumnIntegrationInResponses < ActiveRecord::Migration[5.0]
  def change
    remove_column :responses, :integration
  end
end
