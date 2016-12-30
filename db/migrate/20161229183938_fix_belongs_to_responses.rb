class FixBelongsToResponses < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :responses, :form, index: true
    add_belongs_to :response_properties, :response, index: true
  end
end
