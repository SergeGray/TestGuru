class User < ApplicationRecord
  # has_many :attempts
  # has_many :tests, through: :attempts, dependent: :destroy

  def started_by_level(level)
    Test.joins(
      "JOIN attempts ON attempts.test_id = tests.id"
    ).where(attempts: { user_id: id }, level: level)
  end
end
