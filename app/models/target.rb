class Target < ApplicationRecord
  belongs_to :user

  enum period: { long: 1, middle: 2, short: 3 }
  enum achieve: { goal: true, un_goal: false }
end
