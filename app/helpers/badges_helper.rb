module BadgesHelper
  def options
    Badge.conditions.to_a
  end

  def badge_progress(user, badge)
    "#{user.user_badge(badge)&.test_count || 0}/#{badge.required_amount}"
  end
end
