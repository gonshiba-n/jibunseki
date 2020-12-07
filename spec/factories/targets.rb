FactoryBot.define do
  factory :target do
    target_body { "MyString" }
    start { "2020-12-07" }
    deadline { "2020-12-07" }
    achieve { "" }
    period { "" }
    user { nil }
  end
end
