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
    if deadline.nil?
      errors.add(:deadline, "を入力してください")
      return
    end
    errors.add(:deadline, "は、現在時刻よりも後に設定してください。") if Time.now >= deadline
  end

  # 現在時刻と目標設定期限の差
  def time_left
      sec_diff = deadline - Time.now
    (Time.parse("1/1") + sec_diff - (day_diff = sec_diff.to_i / 86400) * 86400).strftime("#{day_diff}日%H時間%M分")
  end

  # プログレスバー%表示
  def rate
    # 全体期間
    term = deadline.to_f - created_at.to_f
    # スタートからの日数
    now = Time.now.to_f - created_at.to_f
    progress = (now / term) * 100
    progress.round(1)
  end

  # 進捗率表示
  def over_rate(rate)
    if rate > 100
      100.to_s + "%"
    else
      rate.to_s + "%"
    end
  end

  def un_goal?
    achieve == "un_goal"
  end

  def over_time?
    deadline < Time.now
  end

  def time_survey?
    un_goal? && over_time?
  end
end
