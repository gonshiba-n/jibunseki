class Tag < ApplicationRecord
  belongs_to :user
  # バリデーション
  validates :question_body, presence: true, length: { maximum: 50 }
  validates :tag, presence: true, length: { maximum: 10 }
  validate :wcm, :wcm_check
  validate :base_tag, :base_tag_check
  validate :limit_check, on: :create

  private

  def wcm_check
    unless wcm == "will" || wcm == "can" || wcm == "must"
      errors.add(:wcm, "不正な値を検出しました")
    end
  end

  def base_tag_check
    if Tag.exists?(user_id: user_id, wcm: wcm, base_tag: true)
      unless Tag.exists?(id: id, base_tag: true)
        errors.add(:base_tag, "の登録は、1件までです")
      end
    end
  end

  # タグの数が６以下なら保存
  def limit_check
    case wcm
    when "will"
      tags = Tag.where(user_id: user_id, wcm: "will")
      if tags.count >= 6
        errors.add(:wcm, "のタグの登録は、それぞれ６件までです")
      end
    when "must"
      tags = Tag.where(user_id: user_id, wcm: "must")
      if tags.count >= 6
        errors.add(:wcm, "のタグの登録は、それぞれ６件までです")
      end
    when "can"
      tags = Tag.where(user_id: user_id, wcm: "can")
      if tags.count >= 6
        errors.add(:wcm, "のタグの登録は、それぞれ６件までです")
      end
    else
      errors.add(:wcm, "不正な値です")
    end
  end
end
