class AddTimesReviewedAndRankToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :times_reviewed, :integer
    add_column :responses, :rank, :integer
  end
end
