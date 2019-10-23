class TestsMailer < ApplicationMailer
  def completed_test(attempt)
    @user = attempt.user
    @test = attempt.test

    mail to: @user.email
  end
end
