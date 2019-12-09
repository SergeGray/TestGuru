class BadgeAwardService
  def initialize(user)
    @user = user
    @badges = Badge.all
  end

  def call
    @badges.select do |badge|
      send(badge.condition, badge)
    end
  end

  private

  def required_amount(badge)
    case badge.condition
    when "all_with_level" || "all_in_category" then 1
    else badge.condition_value
    end
  end

  def new_passed(badge)
    @user.attempts.where(
      "passed = true and updated_at > ?",
      @user.user_badge(badge)&.created_at || Time.at(0)
    )
  end

  def passed_tests_count(badge)
    new_passed(badge).select(:test_id).distinct.count
  end
     
  def first_try(badge)
    new_passed(badge).select do |attempt|
      @user.attempts.where(test_id: attempt.test.id).count == 1
    end.count == required_amount(badge)
  end

  def all_with_level(badge)
    passed_tests_count(badge) == Test.of_level(badge.condition_value).count
  end

  def all_in_category(badge)
    passed_tests_count(badge) == Test.of_category(badge.condition_value).count
  end

  def perfect_score(badge)
    new_passed(badge).select do |attempt|
      attempt.score == 100
    end.size == required_amount(badge)
  end
end
