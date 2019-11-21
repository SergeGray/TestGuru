class FeedbackMailer < ApplicationMailer
  default to: -> { User.find_by(type: "Admin").email }

  def send_feedback(email, content)
    @email = email
    @content = content

    mail from: @email
  end
end
