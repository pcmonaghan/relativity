class AddRankToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :rank, :integer
  end
end
