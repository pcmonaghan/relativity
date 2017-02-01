class CreateModelRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :model_ranks do |t|
      t.belongs_to :form, index: true
      t.timestamps
    end
  end
end
