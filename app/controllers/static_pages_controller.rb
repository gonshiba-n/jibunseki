class StaticPagesController < ApplicationController
  skip_before_action :require_login!, only: [:top, :login, :signup]
  def top
  end

  def signup
    @user = User.new
  end

  def login
    @user = User.new
  end

end
