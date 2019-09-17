module QuestionsHelper
  ACTIONS = { new: "Create new", edit: "Edit" }.freeze

  def question_header(question)
    action = question.new_record? ? :new : :edit
    "#{ACTIONS[action]} #{question.test.title} question"
  end
end
