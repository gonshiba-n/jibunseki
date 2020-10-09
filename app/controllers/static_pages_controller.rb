class StaticPagesController < ApplicationController
  def top
  end

  def signup
    @user = User.new
  end

  def login
  end
end
