# README

Quiz web application written using Ruby on Rails.

Things to add to the application:

Models:

1. Question - belongs to test, has many answers

  Params:

    * body of the question

2. Answer - belongs to question

  Params:

    * body of the answer

    * correct/incorrect


3. Test - has many questions, has many attempts, belongs to user(?)

  Params: TBA

4. User - has many attempts, creates questions (admin)

  Params:

    * name

    * password

5. Attempt - belongs to user, belongs to test, an attempt to solve a test.

  Params:

    * correct answers

    * incorrect answers

    * unanswered

    * time spent



Things to be added to README:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
