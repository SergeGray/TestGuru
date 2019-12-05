class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge
  has_many :user_badge_tests, dependent: :destroy
  has_many :tests, through: :user_badge_tests

  def progress
    100 * tests.count / badge.required_amount
  end
end
