class BadgeAwardService
  def initialize(user)
    @user = user
    @badges = Badge.all
    @successful_attempts = @user.attempts.select do |attempt|
      attempt.successful?
    end
  end

  def call
    @badges.select do |badge|
      send(badge.condition, badge.condition_value, required_amount(badge))
    end
  end

  private

  def required_amount(badge)
    badge_multiplier(badge) * (@user.badge_count(badge) + 1)
  end

  def badge_multiplier(badge)
    case badge.condition
    when "all_with_level" || "all_in_category" then 1
    else badge.condition_value
    end
  end
     
  def first_try(_, amount)
    @successful_attempts.select do |attempt|
      @user.attempts.where(test_id: attempt.test.id).count == 1
    end.count == amount
  end

  def all_with_level(condition_value, amount)
    Test.of_level(condition_value).all? do |test|
      @successful_attempts.select do |attempt|
        attempt.test_id == test.id
      end.size >= amount
    end
  end

  def all_in_category(condition_value, amount)
    Test.of_category(condition_value).all? do |test|
      @successful_attempts.select do |attempt|
        attempt.test_id == test.id
      end.size >= amount
    end
  end

  def perfect_score(_, amount)
    @successful_attempts.select do |attempt|
      attempt.score == 100
    end.size == amount
  end
end
