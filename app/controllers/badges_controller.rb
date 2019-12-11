class BadgesController < ApplicationController
  before_action :authenticate_user!

  def index
    @badges = Badge.all
  end

  def show
    @badge = Badge.find(params[:id])
  end
end
