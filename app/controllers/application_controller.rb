class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :require_login!
  before_action :set_search
  helper_method :logged_in?

  # cookieからトークンを取得して暗号化
  # cookieと同じトークンを持つuserを取得
  def current_user
    remember_token = User.encrypt(session[:user_remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  # ログイン
  def login(user)
    remember_token = User.new_remember_token
    session[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
  end

  # ログアウト/クッキー削除
  def logout
    @current_user = nil
    reset_session
  end

  # 値があればtrue
  def logged_in?
    @current_user.present?
  end

  # ransack
  def set_search
    @q = Company.ransack(params[:q])
    @search_conpanies = @q.result.order(created_at: "DESC")
  end

  private

  # ログインしていなければ、ルートパスへ返す
  def require_login!
    redirect_to root_path unless logged_in?
  end
end
