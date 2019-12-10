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
    return if @user.attempts.where(test_id: @attempt.test.id).count != 1

    new_passed(badge).select do |passed|
      @user.attempts.where(test_id: passed.test.id).count == 1
    end.count == badge.condition_value
  end

  def all_with_level(badge)
    return if @attempt.test.level != badge.condition_value

    passed_tests_count(badge) == Test.of_level(badge.condition_value).count
  end

  def all_in_category(badge)
    return if @attempt.test.category.id != badge.condition_value

    passed_tests_count(badge) == Test.of_category(badge.condition_value).count
  end

  def perfect_score(badge)
    return if @attempt.score != 100

    new_passed(badge).select do |passed|
      passed.score == 100
    end.size == badge.condition_value
  end
end
