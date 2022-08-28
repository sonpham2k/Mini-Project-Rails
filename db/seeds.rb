# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "Example User",
            email: "example@gmail.com",
            is_admin: true,
            password: "123123")

50.times do |n|
    name = Faker::Name.name
    email = "exampleUser-#{n+1}@gmail.com"
    password = "123123"
    User.create!(name: name,
                email: email,
                is_admin: false,
                password: password)
end
