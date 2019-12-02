module BadgesHelper
  def options
    Badge.conditions.to_a
  end
end
