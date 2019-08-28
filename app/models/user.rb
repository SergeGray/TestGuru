class User < ApplicationRecord
  # has_many :attempts
  # has_many :tests, through: :attempts, dependent: :destroy

  def started_by_level(level)
    Test.joins(
      "JOIN attempts ON attempts.test_id = tests.id "\
      "JOIN users ON users.id = attempts.user_id"
    ).where("user.id": id, level: level)
  end
end
