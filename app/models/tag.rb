class Tag < ApplicationRecord
  belongs_to :user
  # バリデーション
  validates :question_body, presence: true, length: { maximum: 50 }
  validates :tag, presence: true, length: { maximum: 10 }
end
