class User < ApplicationRecord
  has_many :attempts, dependent: :destroy
  has_many :tests, through: :attempts
  has_many :created_tests, class_name: "Test",
                           foreign_key: "author_id",
                           dependent: :nullify
  has_many :gists, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  validates :first_name, presence: true

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  def started_by_level(level)
    tests.where(level: level)
  end

  def attempt(test)
    attempts.order(id: :desc).find_by(test_id: test.id)
  end

  def user_badge(badge)
    user_badges.order(id: :desc).find_by(badge_id: badge.id, completed: false)
  end

  def admin?
    is_a?(Admin)
  end

  def badge_count(badge)
    user_badges.where(badge_id: badge.id, completed: true).count
  end

  def successful_attempts
    attempts.filter(&:successful?)
  end
end
