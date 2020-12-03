class Tag < ApplicationRecord
  belongs_to :user
  # バリデーション
  validates :question_body, presence: true, length: { maximum: 50 }
  validates :tag, presence: true, length: { maximum: 10 }
  validate :wcm, :wcm_check
  validate :wcm, :limit_check, on: :create

  # スコープ
  scope :tags, -> (wcm) { where(wcm: wcm) }
  scope :sorted, -> { order(created_at: :desc) }
  scope :recent, -> (wcm) { tags(wcm).sorted }
  # nil許容のため、scopeではなくメソッド定義とした
  def self.base(wcm)
    find_by(wcm: wcm, base_tag: true)
  end

  private

  def wcm_check
    unless wcm == "will" || wcm == "can" || wcm == "must"
      errors.add(:wcm, "不正な値を検出しました")
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
