class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show

  end

  def create
    @user = User.new(user_params)
    if @user.save
      puts "ログインできたよ"
      redirect_to user_path(@user.id), notice:"#{@user.name}さん！登録が完了しました。"
    else
      puts "ログインできてないよ"
      render template: "static_pages/signup"
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
