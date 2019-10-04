class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    respond_to do |format|
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_to session[:path] || root_path }
      else
        format.html { render :new }
        flash[:alert] = "Incorrect login data."
      end
    end
  end

  def destroy
    session.delete(:user_id)
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end
end
