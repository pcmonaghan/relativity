class ChangeNextRatingToFloatInResponses < ActiveRecord::Migration[5.0]
  def change
    change_column :responses, :next_rating, :float
  end
end
