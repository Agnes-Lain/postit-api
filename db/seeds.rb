# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create 2 users
puts "Creating 3 users..."
user1 = User.new(user_name: "User 1", email:"test_user1@gmail.com", password:"password1")
user1.save
user2 = User.new(user_name: "User 2", email:"test_user2@gmail.com", password:"password2")
user2.save
user3 = User.new(user_name: "User 3", email:"test_user3@gmail.com", password:"password3")
user3.save

puts "Creating 3 posts for users1..."
# Create 3 posts for user 1
n = 1
3.times do
  user1.posts.create!(title: "Post Title#{n}", content: "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.")
  n += 1
end

puts "Creating 3 posts for user2..."
# Create 3 posts for user 2
3.times do
  user2.posts.create!(title: "Post Title #{n}", content: "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.")
  n += 1
end

puts "Creating 3 posts for user3..."
# Create 3 posts for user 2
3.times do
  user3.posts.create!(title: "Post Title #{n}", content: "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.")
  n += 1
end

puts "Finished"
