FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { "1234" }
    role { :default }
    active? { true }
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
