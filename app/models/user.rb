class User < ApplicationRecord
  has_many :attempts
  has_many :tests, through: :attempts, dependent: :destroy
  has_many :created_tests, class_name: "Test", foreign_key: "author_id" 

  def started_by_level(level)
    Test.joins(:attempts).where(attempts: { user_id: id }, level: level)
  end
end
