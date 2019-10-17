# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    super
    flash[:notice] = "Welcome back, #{current_user.first_name}"
  end
end
