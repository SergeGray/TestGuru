module BadgesHelper
  def condition_select
    select(
      :badge,
      :condition,
      BadgeAwardService::CONDITIONS.map do |condition|
        [t(".#{condition}"), condition]
      end,
      { prompt: true, class: "form-control" }
    )
  end
end
