class Tag < ApplicationRecord
  belongs_to :user
  # バリデーション
  validates :question_body, presence: true, length: { maximum: 50 }
  validates :tag, presence: true, length: { maximum: 10 }
  validate :wcm, :wcm_check
  # validate :base_tag, :base_tag_check

  private

  def wcm_check
    unless wcm == "will" || wcm == "can" || wcm == "must"
      errors.add(:wcm, "不正な値を検出しました")
    end
  end

  def base_tag_check
    # ユーザーの作成したタグがwill,can,mustで振り分け

    # base_tagのtrueだけをDBから抽出し１よりもカウントが大きければエラー
  end
end
