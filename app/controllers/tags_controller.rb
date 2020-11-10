class TagsController < ApplicationController
  def create
    @tag = @current_user.tag.new(tags_params)
    respond_to do |format|
      if @tag.save
        format.js
      else
        format.js { render :create_errors }
      end
    end
    set_tags
  end

  def update
    @tag = @current_user.tag.find(tags_params[:id])
    respond_to do |format|
      if @tag.update(tags_params)
        format.js
      else
        format.js { render :edit_errors }
      end
    end
    set_tags
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to user_path(@current_user.id), notice: "#{@current_user.name}さん！タグを削除しました。"
  end

  private

  def tags_params
    params.require(:tag).permit(:id, :question_body, :tag, :wcm)
  end

  def set_tags
    @will_tags = @current_user.tag.where(wcm: "will")
    @can_tags = @current_user.tag.where(wcm: "can")
    @must_tags = @current_user.tag.where(wcm: "must")
  end
end
