FactoryBot.define do
  factory :target, class: Target do
    id { 1 }
    target_body { "MiddleTarget" }
    deadline { "2020-12-30 00:00:00" }
    achieve { "un_goal" }
    period { "middle" }
    created_at { "2020-12-01 00:00:00" }
    updated_at { "2020-12-01 00:00:00" }
    association :user
  end

  factory :target_long, class: Target do
    id { 2 }
    target_body { "LongTarget" }
    deadline { "2021-12-01 00:00:00" }
    achieve { "un_goal" }
    period { "long" }
    created_at { "2020-12-01 00:00:00" }
    updated_at { "2020-12-01 00:00:00" }
    association :user
  end

  factory :target_short, class: Target do
    id { 3 }
    target_body { "ShortTarget" }
    deadline { "2020-12-7 00:00:00" }
    achieve { "goal" }
    period { "short" }
    created_at { "2020-12-01 00:00:00" }
    updated_at { "2020-12-01 00:00:00" }
    association :user
  end
end
