categories = Category.create!(
  [
    { title: 'Scripting' },
    { title: 'Web Development' },
    { title: 'Low level' }
  ]
)
users = User.create!(
  [
    { name: 'Vladimir' },
    { name: 'Dmitry' },
    { name: 'Angrey' },
    { name: 'Egor' }
  ]
)
tests = Test.create!(
  [
    { title: 'Python', category_id: categories.first.id },
    { title: 'Ruby', category_id: categories.first.id },
    { title: 'Ruby on Rails', category_id: categories.second.id, level: 1 },
    { title: 'Javascript', category_id: categories.second.id, level: 2 },
    { title: 'C', category_id: categories.third.id, level: 4 },
    { title: 'Assembly', category_id: categories.third.id, level: 5 }
  ]
)
attempts = Attempt.create!(
  [
    { user_id: users.first.id, test_id: tests.first.id, score: 16 },
    { user_id: users.first.id, test_id: tests.third.id, score: 51, finished: true },
    { user_id: users.second.id, test_id: tests.second.id, score: 32 },
    { user_id: users.second.id, test_id: tests.fifth.id, score: 44, finished: true },
    { user_id: users.third.id, test_id: tests.third.id, score: 29 },
    { user_id: users.third.id, test_id: tests.last.id, score: 10 },
    { user_id: users.fourth.id, test_id: tests.fourth.id, score: 17 },
    { user_id: users.fourth.id, test_id: tests.first.id, score: 25, finished: true }
  ]
)
questions = Question.create!(
  [
    { body: 'Python standard indentation length in spaces', test_id: tests.first.id },
    { body: 'What is the language named after?', test_id: tests.first.id },
    { body: 'Ruby standard indentation length in spaces', test_id: tests.second.id },
    { body: 'Which of the following is not an output method?', test_id: tests.second.id },
    { body: 'Superclass of ApplicationController', test_id: tests.third.id },
    { body: 'Which of the following is not a standard view file name?', test_id: tests.third.id }
  ]
)
Answer.create!(
  [
    { body: '2', question_id: questions.first.id },
    { body: '4', question_id: questions.first.id, correct: true },
    { body: 'Snake', question_id: questions.second.id, },
    { body: 'British comedy group', question_id: questions.second.id, correct: true },
    { body: '2', question_id: questions.third.id, correct: true },
    { body: '4', question_id: questions.third.id },
    { body: 'print', question_id: questions.fourth.id },
    { body: 'output', question_id: questions.fourth.id, correct: true },
    { body: 'ActionController::Base', question_id: questions.fifth.id, correct: true },
    { body: 'ActiveController', question_id: questions.fifth.id },
    { body: 'show', question_id: questions.last.id },
    { body: 'change', question_id: questions.last.id, correct: true }
  ]
)
