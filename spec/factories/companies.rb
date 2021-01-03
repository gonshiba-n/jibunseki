FactoryBot.define do
  factory :company do
    id { 1 }
    name { "MyString" }
    url { "https://jibunseki.herokuapp.com" }
    business { "MyBusiness" }
    business_fit { 5 }
    culture { "MyCulture" }
    culture_fit { 5 }
    vision { "MyVision" }
    vision_fit { 5 }
    future { "MyFuture" }
    future_fit { 5 }
    skill { "MySkill" }
    skill_fit { 5 }
    treatment { "MyTreatment" }
    treatment_fit { 5 }
    association :user
  end
end
