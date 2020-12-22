class Company < ApplicationRecord
  belongs_to :user

  def aspiration
    result = [
            business_fit,
            culture_fit,
            vision_fit,
            future_fit,
            skill_fit,
            treatment_fit,
          ]
    result.sum
  end

  place_holder = {
    business: "事業内容の共感するポイントをまとめましょう。"
  }
end
