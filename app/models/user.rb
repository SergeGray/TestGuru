class User < ApplicationRecord
  has_many :attempts
  has_many :tests, through: :attempts, dependent: :destroy

  def started_by_level(level)
    tests.where(level: level)
  end
end
