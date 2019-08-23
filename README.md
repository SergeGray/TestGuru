# README

Quiz web application written using Ruby on Rails.

Things to add to the application:

Models:

1. Question - belongs to test

  Params:

    * body of the question

    * answer

2. Test - has many questions, has many attempts, belongs to user(?)

  Params: TBA

3. User - has many attempts, creates questions (admin)

  Params:

    * name

    * password

4. Attempt - belongs to user, belongs to test, an attempt to solve a test.

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
