# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create(name: "TV Commedies")
Category.create(name: "TV Dramas")
Category.create(name: "Reality TV")
arr = %w(monk south_park family_guy futurama)

user = User.create(name: "Jack", email: "a@1.com", password: "fuck")

Category.all.each do |category|
  8.times do |n|
    temp_title = arr.sample
    video = category.videos.create(title: temp_title,
                 description: Faker::Lorem.sentence(20, true),
                 smaller_cover_url: "/tmp/#{temp_title}.jpg",
                 larger_cover_url: "/tmp/monk_large.jpg")
    3.times { video.reviews.create(user: user, content: Faker::Lorem.sentence(3, true), score: Faker::Number.between(1, 5)) }
  end
end

