class Admin::TestsController < Admin::BaseController
  before_action :set_tests, only: %i[index update_inline]
  before_action :set_test, only: %i[
    show edit update update_inline destroy start
  ]

  def index; end

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = current_user.created_tests.new(test_params)
    respond_to do |format|
      if @test.save
        format.html do
          redirect_to admin_test_path(@test), notice: t('.success')
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to admin_test_path(@test) }
      else
        format.html { render :edit }
      end
    end
  end

  def update_inline
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to admin_tests_path }
      else
        format.html { render :index }
      end
    end
  end

  def destroy
    @test.destroy

    respond_to do |format|
      format.html { redirect_to admin_tests_url }
    end
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def set_tests
    @tests = Test.all
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end
end
