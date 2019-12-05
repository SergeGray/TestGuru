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

  def admin?
    is_a?(Admin)
  end

  def successful_attempts
    attempts.filter(&:successful?)
  end
end
