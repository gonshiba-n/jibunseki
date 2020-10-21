class TagsController < ApplicationController
  def create
    @tag = @current_user.tag.new(tags_params)
    if @tag.save
      redirect_to user_path(@current_user.id), notice:"#{@current_user.name}さん！タグを作成しました。"
    else
      redirect_to user_path(@current_user.id), notice:"#{@current_user.name}さん！タグを作成できませんでした。"
    end
  end

  def update

  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to user_path(@current_user.id), notice:"#{@current_user.name}さん！タグを削除しました。"
  end

  private

  def tags_params
    params.require(:tag).permit(:id, :question_body, :tag, :wcm)
  end
end
