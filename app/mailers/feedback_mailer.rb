class FeedbackMailer < ApplicationMailer
  default to: Admin.first.email

  def send_feedback(feedback)
    @email = feedback.email
    @content = feedback.content

    mail from: @email
  end
end
