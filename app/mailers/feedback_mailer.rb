class FeedbackMailer < ApplicationMailer
  default to: -> { User.find_by(type: "Admin").email }

  def send_feedback(feedback)
    @email = feedback.email
    @content = feedback.content

    mail from: @email
  end
end
