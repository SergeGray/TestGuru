class TestsMailer < ApplicationMailer
  def completed_test(attempt)
    @user = attempt.user
    @test = attempt.test

    mail to: @user.email, subject: 'You just completed a TestGuru test!'
  end
end
