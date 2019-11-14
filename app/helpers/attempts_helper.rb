module AttemptsHelper
  PASSING_SCORE = 85

  def result(attempt)
    pass = attempt.successful? ? "passed" : "failed"
    p_class = { "passed" => "text-success", "failed" => "text-danger" }
    content_tag(
      :p,
      "#{attempt.score}% - #{t('.' + pass)}",
      class: p_class[pass]
    )
  end

  def progress(attempt)
    "#{attempt.current_question_index + 1}/#{attempt.total_questions}"
  end
end
