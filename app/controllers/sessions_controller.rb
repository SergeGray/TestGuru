class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    respond_to do |format|
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_to tests_path }
      else
        format.html { render :new }
      end
    end
  end
end
