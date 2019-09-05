module QuestionsHelper
  ACTIONS = { new: "Create new", edit: "Edit" }

  def question_header(action, test)
    "#{ACTIONS[action]} #{test.title} question"
  end 
end
