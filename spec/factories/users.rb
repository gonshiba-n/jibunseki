FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'test_user' }
    email { 'test@example.com' }
    password { 'password' }

    trait :invalid do
      password { 'pass' }
    end
  end
end
