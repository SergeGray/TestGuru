class FeedbackMailer < ApplicationMailer
  def send_feedback(user, content)
    @user = user
    @content = content
    admin = User.find_by(type: "Admin")

    mail to: admin.email
  end
end
