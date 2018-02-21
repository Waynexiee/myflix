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

