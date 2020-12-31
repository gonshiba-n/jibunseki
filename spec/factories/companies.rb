FactoryBot.define do
  factory :company do
    name { "MyString" }
    url { "https://jibunseki.herokuapp.com" }
    business { "MyText" }
    business_fit { 5 }
    vision { "MyText" }
    vision_fit { 5 }
    culture { "MyText" }
    culture_fit { 5 }
    future { "MyText" }
    future_fit { 5 }
    skill { "MyText" }
    skill_fit { 5 }
    treatment { "MyText" }
    treatment_fit { 5 }
    association :user
  end
end
