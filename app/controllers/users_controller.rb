class UsersController < ApplicationController
  skip_before_action :require_login!, only: [:new, :create]

  def index
    @user = User.new
  end

  def new
    @user = User.new
  end

  def show
    set_tag
  end

  # サインアップ処理 => DBにuser_paramsからのデータを保存
  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_path(@user.id), notice: "#{@user.name}さん！登録が完了しました。"
    else
      render :new
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_tag
    @tag = Tag.new
    @will_tags = @current_user.tag.where(wcm: 'will')
    @can_tags = @current_user.tag.where(wcm: 'can')
    @must_tags = @current_user.tag.where(wcm: 'must')
    @will_base = @current_user.tag.find_by(wcm: 'will', base_tag: true)
    @can_base = @current_user.tag.find_by(wcm: 'can', base_tag: true)
    @must_base = @current_user.tag.find_by(wcm: 'must', base_tag: true)
  end
end
