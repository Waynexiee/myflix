Fabricator(:user) do
  email { Faker::Internet.email }
  name { Faker::Name.name }
  password { Faker::Number.number(10) }
end

Fabricator(:admin, from: :user) do
  admin true
end
