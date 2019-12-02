class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge
  has_many :tests, through: :user_badge_tests
  has_many :user_badge_tests, dependent: :destroy

  def award
    if user_badge_tests.count == badge.required_amount?
      self.completed = true
      self.save!
      user.badges.push(badge)
    end
  end
end
