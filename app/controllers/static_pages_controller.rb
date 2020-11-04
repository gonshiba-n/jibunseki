class StaticPagesController < ApplicationController
  skip_before_action :require_login!, only: [:top, :login, :signup]
  def top
    if logged_in?
      redirect_to user_path(:user_id)
    end
  end

  def login
    @user = User.new
  end
end
