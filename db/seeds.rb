# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Form.create(integration: 'wufoo', num_records: '0', user_id: '1', name: "DSSG 2017 App", num_reviews: 0, user_id: 1)
user = User.new(
      :email                 => "development@example.com",
      :password              => "password",
      :password_confirmation => "password"
  )
user.save!
