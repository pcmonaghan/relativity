class RenameRankToRatingInResponses < ActiveRecord::Migration[5.0]
  def change
    rename_column :responses, :rank, :rating
    add_column :responses, :next_rating, :integer, default: -1
  end
end
