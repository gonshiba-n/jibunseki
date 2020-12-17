class Target < ApplicationRecord
  belongs_to :user

  validates :target_body, presence: true, length: { maximum: 50 }
  validates :deadline, presence: true
  validates :achieve, presence: true, inclusion: { in: ["goal", "un_goal"] }, on: :update
  validates :period, presence: true
  validate :check_times

  # スコープ
  scope :time_order, -> { order(deadline: "DESC") }

  enum period: { long: 1, middle: 2, short: 3 }
  enum achieve: { goal: true, un_goal: false }

  def check_times
    if start.nil? || deadline.nil?
      errors.add(:start, "を入力してください")
      return
    end
    errors.add(:start, "は、目標達成予定日時よりも前に設定してください。") if start > deadline
  end

  # 現在時刻と目標設定期限の差
  def time_left
    if start > Time.now
      sec_diff = start - Time.now
    else
      sec_diff = deadline - Time.now
    end
    (Time.parse("1/1") + sec_diff - (day_diff = sec_diff.to_i / 86400) * 86400).strftime("#{day_diff}日%H時間%M分")
  end
end
