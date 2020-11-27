FactoryBot.define do
  factory :tag do
    sequence(:question_body) { |n| "will#{n}" }
    tag { 'will_tag' }
    wcm { 'will' }
    base_tag { false }
    association :user

    trait :base_tag do
      base_tag { true }
    end

    trait :can do
      tag { 'can_tag' }
      wcm { 'can' }
    end

    trait :must do
      tag { 'must_tag' }
      wcm { 'must' }
    end

    trait :none do
      tag { 'none' }
      wcm { 'none' }
    end
  end
end
