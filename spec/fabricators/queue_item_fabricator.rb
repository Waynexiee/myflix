Fabricator(:queue_item) do
  order {Faker::Number.between(1, 10)}
end
