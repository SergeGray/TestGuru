module BadgesHelper
  def condition_select
    select(
      :badge,
      :condition,
      Badge.conditions.keys.map { |condition| [t(".#{condition}"), condition] },
      { prompt: true, class: "form-control" }
    )
  end
end
