class Company < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 30 }
  validates :url, presence: true
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

  with_options length: { maximum: 3000 } do
    validates :business,
              :culture,
              :vision,
              :future,
              :skill,
              :treatment
  end
  with_options numericality: { only_integer: true, greater_than: 0, less_than: 6 } do
    validates :business_fit,
              :culture_fit,
              :vision_fit,
              :future_fit,
              :skill_fit,
              :treatment_fit
  end

  scope :sorted, -> { order(created_at: :desc) }

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
end
