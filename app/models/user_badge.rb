class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge
  has_many :user_badge_tests, dependent: :destroy
  has_many :tests, through: :user_badge_tests
  validates :progress, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100,
    only_integer: true
  }, allow_nil: false
end
