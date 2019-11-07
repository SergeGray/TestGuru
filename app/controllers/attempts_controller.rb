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
    response = GistQuestionService.new(@attempt.current_question).call
    if response.key?(:html_url)
      Gist.create!(
        user: current_user,
        url: response[:html_url],
        question: @attempt.current_question
      )
      flash[:notice] = "#{t('.success')}<br>#{gist_link(response)}<br />"
    else
      flash[:alert] =  t('.failure')
    end

    respond_to do |format|
      format.html { redirect_to @attempt }
    end
  end

  private

  def set_attempt
    @attempt = Attempt.find(params[:id])
  end

  def gist_link(response)
    view_context.link_to t('.gist_link'), response[:html_url], target: "_blank"
  end
end
