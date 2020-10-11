class SessionsController < ApplicationController
  skip_before_action :require_login!, only: [:create, :destroy]
  before_action :set_user, only: [:create]

  # ログイン処理
  def create
    if @user.authenticate(session_params[:password])
      login(@user)
      redirect_to user_path(@user.id), notice:"#{@user.name}さん！ログインしました。"
    else
      flash[:danger] = 'メールアドレスとパスワードの組み合わせが誤っています'
      redirect_to login_path
    end
  end

  # ログアウト処理
  def destroy
    logout
    redirect_to root_path, notice:"ログアウトしました。"
  end

  private

  def set_user
    @user = User.find_by(email: session_params[:email])
  rescue
    flash[:danger] = 'メールアドレスとパスワードの組み合わせが誤っています'
    redirect_to login_path
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
