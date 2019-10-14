class TestsController < ApplicationController
  before_action :authenticate_user!, only: :start
  before_action :set_test, only: :start

  def index
    @tests = Test.all
  end

  def start
    current_user.tests.push(@test)
    respond_to do |format|
      format.html { redirect_to current_user.attempt(@test) }
    end
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end
end
