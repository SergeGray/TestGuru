class AttemptsController < ApplicationController
  before_action :authenticate_user!, except: :result
  before_action :set_attempt, only: %i[show update result gist]

  def show; end

  def result; end

  def update
    @attempt.accept!(params[:answer_ids])

    respond_to do |format|
      if @attempt.completed?
        format.html do
          TestsMailer.completed_test(@attempt).deliver_now
          redirect_to result_attempt_path(@attempt)
        end
      else
        format.html { render :show }
      end
    end
  end

  def gist
    result = GistQuestionService.new(@attempt.current_question).call
    flash_options = if result.success?
                      { notice: t('.success') }
                    else
                      { alert: t('.failure') }
                    end

    respond_to do |format|
      format.html { redirect_to @attempt, flash_options }
    end
  end

  private

  def set_attempt
    @attempt = Attempt.find(params[:id])
  end
end
