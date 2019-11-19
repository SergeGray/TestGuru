module AttemptsHelper
  PASSING_SCORE = 85

  def result(attempt)
    pass, html_class = if attempt.successful?
                         [".passed", "text-success"]
                       else
                         [".failed", "text-danger"]
                       end
    content_tag :p, "#{attempt.score}% - #{t(pass)}", class: html_class
  end

  def progress(attempt)
    "#{attempt.current_question_index + 1}/#{attempt.total_questions}"
  end
end
