class User < ApplicationRecord
  # has_many :attempts
  # has_many :tests, through: :attempts, dependent: :destroy

  def started_by_level(level)
    Test.where(
      id: Attempt.where(user_id: id).pluck(:test_id), level: level
    )
  end
end
