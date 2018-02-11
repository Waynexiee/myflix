Fabricator(:review) do
  content {Faker::Lorem.sentence(3, true)}
  score {Faker::Number.between(1, 5)}
end