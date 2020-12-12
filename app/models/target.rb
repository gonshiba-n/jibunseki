class Target < ApplicationRecord
  belongs_to :user

  enum period: { long: 1, middle: 2, short: 3 }
  enum achieve: { goal: true, un_goal: false }

  def time_left
    sec_diff = deadline - Time.now
    (Time.parse("1/1") + sec_diff - (day_diff = sec_diff.to_i / 86400) * 86400).strftime("#{day_diff}日%H時間")
  end
end
