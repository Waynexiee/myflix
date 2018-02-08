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
Category.all.each do |category|
  20.times do |n|
    temp_title = arr.sample
    category.videos.create(title: temp_title,
                 description: "This file should contain all the record creation needed to seed the database with its default values.",
                 smaller_cover_url: "/tmp/#{temp_title}.jpg",
                 larger_cover_url: "/tmp/monk_large.jpg")
  end
end

