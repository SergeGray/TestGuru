class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :attempts, dependent: :destroy
  has_many :tests, through: :attempts
  has_many :created_tests, class_name: "Test",
                           foreign_key: "author_id",
                           dependent: :nullify

  validates :first_name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  def started_by_level(level)
    tests.where(level: level)
  end

  def attempt(test)
    attempts.order(id: :desc).find_by(test_id: test.id)
  end
end
