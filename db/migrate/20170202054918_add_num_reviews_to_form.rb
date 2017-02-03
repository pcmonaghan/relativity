class AddNumReviewsToForm < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :num_reviews, :integer, default: 0 
  end
end
