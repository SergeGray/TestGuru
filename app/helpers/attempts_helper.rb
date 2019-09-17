module AttemptsHelper
  PASSING_SCORE = 85

  def result(attempt)
    pass, color = attempt.successful? ? "passed" : "failed"
    "<div class=#{pass}>#{attempt.score}% - #{pass}</div>".html_safe
  end

  def progress(attempt)
    "#{attempt.current_question_index + 1}/#{attempt.total_questions}"
  end
end
