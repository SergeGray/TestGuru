module AttemptsHelper
  PASSING_SCORE = 85

  def result(attempt)
    # Move these to stylesheets later
    pass, color = if attempt.score >= PASSING_SCORE
                    ["passed", "#00FF00"]
                  else
                    ["failed", "#FF0000"]
                  end
    "<font color=#{color}>"\
    "#{attempt.score.round(2)}% - #{pass}"\
    "</font>".html_safe
  end

  def progress(attempt)
    "#{attempt.current_question_index}/#{attempt.total_questions}"
  end
end
