FactoryBot.define do
  factory :guideline do
    text { "行動指針テキスト"}
    association :user
  end
end