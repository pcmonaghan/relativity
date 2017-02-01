class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :form, index: true
      t.belongs_to :user, index: true
      t.integer :response_one_id
      t.integer :response_two_id
      t.integer :stat_machine_learning_skill
      t.integer :social_science_skill
      t.integer :programming_cs_skill
      t.integer :team_skill
      t.integer :data_skill
      t.integer :communication_skill
      t.integer :care_about_social_good
      t.integer :overall

      t.timestamps
    end
  end
end
