class BadgeAwardService
  CONDITIONS = %w[
    first_try all_with_level all_in_category perfect_score
  ].freeze

  def initialize(attempt)
    @attempt = attempt
    @user = @attempt.user
    @badges = Badge.all
  end

  def call
    @badges.select do |badge|
      send(badge.condition, badge)
    end
  end

  private

  def last_award(badge)
    @user.user_badge(badge)&.created_at || Time.at(0)
  end

  def new_passed(badge)
    @user.attempts.passed.where("updated_at > ?", last_award(badge))
  end

  def passed_tests_count(badge)
    new_passed(badge).select(:test_id).distinct.count
  end
     
  def first_try(badge)
    return if @attempt.test.id != badge.condition_value
    
    @user.attempts.where(test_id: badge.condition_value).count == 1
  end

  def all_with_level(badge)
    return if @attempt.test.level != badge.condition_value

    passed_tests_count(badge) == Test.of_level(badge.condition_value).count
  end

  def all_in_category(badge)
    return if @attempt.test.category.id != badge.condition_value

    passed_tests_count(badge) == Test.of_category(badge.condition_value).count
  end
end
