categories = Category.create!(
  [
    { title: 'Scripting' },
    { title: 'Web Development' },
    { title: 'Low level' }
  ]
)
users = User.create!(
  [
    { name: 'Vladimir', email: 'vladimir@gmail.com', password: '123123' },
    { name: 'Dmitry', email: 'dmitry@yandex.ru', password: 'password' },
    { name: 'Angrey', email: 'andrey@hotmail.com', password: 'qwerty' },
    { name: 'Egor', email: 'egor@mail.ru', password: 'dQw4w9WgXcQ' }
  ]
)
tests = Test.create!(
  [
    {
      title: 'Python',
      category: categories.first,
      author: users.first
    }, {
      title: 'Ruby',
      category: categories.first,
      author: users.first
    }, {
      title: 'Ruby on Rails',
      category: categories.second,
      level: 1,
      author: users.second
    }, {
      title: 'Javascript',
      category: categories.second,
      level: 2,
      author: users.second
    }, {
      title: 'C',
      category: categories.third,
      level: 4,
      author: users.third
    }, {
      title: 'Assembly',
      category: categories.third,
      level: 5,
      author: users.fourth
    }
  ]
)
Attempt.create!(
  [
    { user: users.first, test: tests.first },
    { user: users.first, test: tests.third },
    { user: users.second, test: tests.second },
    { user: users.second, test: tests.fifth },
    { user: users.third, test: tests.third },
    { user: users.third, test: tests.last },
    { user: users.fourth, test: tests.fourth },
    { user: users.fourth, test: tests.first }
  ]
)
questions = Question.create!(
  [
    { body: 'Python standard indentation length in spaces', test: tests.first },
    { body: 'What is the language named after?', test: tests.first },
    { body: 'Ruby standard indentation length in spaces', test: tests.second },
    { body: 'Which of the following is not an output method?', test: tests.second },
    { body: 'Superclass of ApplicationController', test: tests.third },
    { body: 'Which of the following is not a standard view file name?', test: tests.third }
  ]
)
Answer.create!(
  [
    { body: '2', question: questions.first },
    { body: '4', question: questions.first, correct: true },
    { body: 'Snake', question: questions.second },
    { body: 'British comedy group', question: questions.second, correct: true },
    { body: '2', question: questions.third, correct: true },
    { body: '4', question: questions.third },
    { body: 'print', question: questions.fourth },
    { body: 'output', question: questions.fourth, correct: true },
    { body: 'ActionController::Base', question: questions.fifth, correct: true },
    { body: 'ActiveController', question: questions.fifth },
    { body: 'show', question: questions.last },
    { body: 'change', question: questions.last, correct: true }
  ]
)
