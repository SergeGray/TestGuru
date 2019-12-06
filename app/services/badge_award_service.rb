class BadgeAwardService
  def initialize(attempt)
    @attempt = attempt
    @user = attempt.user
    @badges = Badge.all
  end

  def call
    populate(@user) if @user.badges.count.zero?

    @badges.each do |badge|
      user_badge = @user.user_badge(badge)
      if (
        accepts?(user_badge.badge, @attempt) &&
        !user_badge.tests.include?(@attempt.test)
      )
        update(user_badge)
      end
      award(user_badge) if eligible?(user_badge)
    end
  end

  private

  def populate(user)
    @badges.each do |badge|
      user.badges.push(badge)
    end
  end

  def accepts?(badge, attempt)
    send(badge.condition, attempt, badge.condition_value)
  end

  def eligible?(user_badge)
    user_badge.progress == 100
  end

  def required_amount(badge)
    case badge.condition
    when "all_with_level" then Test.of_level(badge.condition_value).count
    when "all_in_category" then Test.of_category(badge.condition_value).count
    else badge.condition_value
    end
  end

  def update(user_badge)
    user_badge.tests.push(@attempt.test)
    user_badge.progress = (
      100 * user_badge.tests.count / required_amount(user_badge.badge)
    )
    user_badge.save!
  end

  def award(user_badge)
    user_badge.completed = true
    user_badge.save!
    @user.badges.push(user_badge.badge)
  end

  def test_count
    user_badge_tests.count
  end
     
  def first_try(attempt, _)
    attempt.user.attempts.where(test_id: attempt.test.id).count == 1
  end

  def all_with_level(attempt, condition_value)
    attempt.test.level = condition_value
  end

  def all_in_category(attempt, condition_value)
    attempt.test.category.id = condition_value
  end

  def perfect_score(attempt, _)
    attempt.score == 100
  end
end
