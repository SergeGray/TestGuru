class FeedbackController < ApplicationController
  def index; end

  def send_message
    email, content = feedback_params
    respond_to do |format|
      if email && content
        FeedbackMailer.send_feedback(email, content).deliver_now
        format.html { redirect_to root_path, notice: t('.success') }
      else
        format.html { render :index }
      end
    end
  end
  
  private

  def feedback_params
    params
      .reject { |k, v| k == :email && v !~ URI::MailTo::EMAIL_REGEXP }
        .permit(:email, :content)
  end
end
