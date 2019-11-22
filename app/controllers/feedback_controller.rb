class FeedbackController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    respond_to do |format|
      if @feedback.save
        FeedbackMailer.send_feedback(@feedback).deliver_now
        format.html { redirect_to root_path, notice: t('.success') }
      else
        format.html { render :new }
      end
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :content)
  end
end
