class UsersController < ApplicationController
  skip_before_action :require_login!, only: [:create]

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  # サインアップ処理 => DBにuser_paramsからのデータを保存
  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_path(@user.id), notice:"#{@user.name}さん！登録が完了しました。"
    else
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
