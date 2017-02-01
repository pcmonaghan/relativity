class AddFormBelongsToUser < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :forms, :user, index: true
  end
end
