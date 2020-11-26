class Guideline < ApplicationRecord
  belongs_to :user

  validates :text, presence: true
  validates :text, uniqueness: true
  validates :user_id, presence: true
  validates :user_id, uniqueness: true, on: :user

  attribute :text, :text, default: "私は〇〇をしたい。その理由は、〇〇である。(Willベースタグ)
                                          今まで、～～という経験をしてきた。～～といったスキルもある。(Canベースタグ)
                                          今後は～～することが求められる。そうしたスキル・経験を身に付けて行動していく。(Mustベースタグ)"
end
