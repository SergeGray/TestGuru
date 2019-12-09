module BadgesHelper
  def condition_select
    select(
      :badge,
      :condition,
      Badge.conditions.keys.map { |c| [t(".#{c}"), c] },
      { prompt: true, class: "form-control" }
    )
  end
end
