FactoryBot.define do
  factory :target do
    target_body { "MyString" }
    start { "2020-12-01 00:00:00" }
    deadline { "2020-12-30 00:00:00" }
    achieve { "un_goal" }
    period { "middle" }
    association :user
  end
end