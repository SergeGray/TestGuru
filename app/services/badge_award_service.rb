class BadgeAwardService
  def initialize(attempt)
    @attempt = attempt
    @user = attempt.user
    @badges = Badge.all
  end

  def call
    populate(@user) if @user.badges.count.zero?

    @user.user_badges.each do |user_badge|
      if accepts?(user_badge.badge, @attempt)
        user_badge.tests.push(@attempt.test) 
      end

      if eligible?(user_badge)
        award(user_badge)
      end
    end
  end

  private

  def populate(user)
    @badges.each do |badge|
      user.badges.push(badge)
    end
  end

  def accepts?(badge, attempt)
    send(badge.condition, attempt)
  end

  def required_amount(badge)
    case badge.condition
    when "all_with_level" then Test.of_level(badge.condition_value).count
    when "all_in_category" then Test.of_category(badge.condition_value).count
    else badge.condition_value
    end
  end

  def award(user_badge)
    if user_badge.user_badge_tests.count == user_badge.badge.required_amount
      user_badge.completed = true
      user_badge.save!
      @user.badges.push(user_badge.badge)
    end
  end

  def test_count
    user_badge_tests.count
  end
     
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
