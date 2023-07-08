# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do |n|
  User.create!(
    name: "test#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "test1234"
  )
end

User.all.each do |user|
  3.times do |n|
    user.articles.create!(
      title: "test title#{n + 1}",
      content: "test test test #{n + 1}"
    )
  end
end
