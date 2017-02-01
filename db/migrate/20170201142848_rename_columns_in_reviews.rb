class RenameColumnsInReviews < ActiveRecord::Migration[5.0]
  def change
    rename_column :reviews, :response_one_id, :response1_id
    rename_column :reviews, :response_two_id, :response2_id
  end
end
