class Badge < ApplicationRecord
  enum condition: {
    first_try: 0,
    all_with_level: 1,
    all_in_category: 2,
    perfect_score: 3
  }
  
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, presence: true
  validates :image_url, presence: true
  validates :condition, presence: true
  validates :condition_value, presence: true

  def self.populate(user)
    all.each do |badge|
      user.badges.push(badge)
    end
  end

  def accepts?(attempt)
    send(condition, attempt)
  end

  def user_badge_count(user)
    user_badges.where(user_id: user.id, completed: true).count
  end

  def user_badge(user)
    user_badges.order(id: :desc).find_by(user_id: user.id, completed: false)
  end

  def required_amount
    case condition
    when "all_with_level" then Test.of_level(condition_value).count
    when "all_in_category" then Test.of_category(condition_value).count
    else condition_value
    end
  end

  private
     
  def first_try(attempt)
    attempt.user.attempts.where(test_id: attempt.test.id).count == 1
  end

  def all_with_level(attempt)
    attempt.test.level = condition_value
  end

  def all_in_category(attempt)
    attempt.test.category.id = condition_value
  end

  def perfect_score(attempt)
    attempt.score == 100
  end
end
