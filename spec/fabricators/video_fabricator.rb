Fabricator(:video) do
  description { Faker::Movie.quote }
  title { Faker::Name.name }
end