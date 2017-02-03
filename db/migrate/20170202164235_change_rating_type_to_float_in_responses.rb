class ChangeRatingTypeToFloatInResponses < ActiveRecord::Migration[5.0]
  def change
    change_column :responses, :rating, :float
  end
end
