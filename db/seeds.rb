# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
100.times do
  user = User.new
  user.name = Faker::Name.name
  user.username = user.name[0] + user.name.split[1]
  user.email = Faker::Internet.email
  user.password = "asdasdasd"
  user.password_confirmation = "asdasdasd"
  user.save
  50.times do
    post = Micropost.new
    post.content = Faker::Lorem.sentences(1)[0][0..160]
    post.user = user
    post.save
  end
end
puts 'CREATED DUMMY DATA'
