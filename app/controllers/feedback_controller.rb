class FeedbackController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def send_message
    content = params[:content]
    respond_to do |format|
      if FeedbackMailer.send_feedback(current_user, content).deliver_now
        format.html { redirect_to root_path }
      else
        format.html { render :index }
      end
    end
  end
  
  private

  def feedback_params
    params.permit(:content)
  end
end
