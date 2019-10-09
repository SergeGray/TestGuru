class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_test, only: %i[show edit update destroy start]

  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = Test.new(test_params)
    respond_to do |format|
      if @test.save
        format.html { redirect_to @test }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to @test }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @test.destroy

    respond_to do |format|
      format.html { redirect_to tests_url }
    end
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
