class TagsController < ApplicationController
  def create
    @tag = @current_user.tag.new(tags_params)
    respond_to do |format|
      if @tag.save
        format.js { flash.now[:success] = "タグを作成しました。" }
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
        format.js { flash.now[:success] = "タグを更新しました。" }
      else
        format.js { render :edit_errors }
      end
    end
    set_tags
  end

  def destroy
    if select_tags_params.present?
      select_tags = select_tags_params
      respond_to do |format|
        select_tags.each do |tag|
          @tag = Tag.find(tag)
          if @tag.destroy
            format.js { flash.now[:success] = "タグを削除しました。" }
          else
            format.js { render template: "users/show" }
            flash.now[:alert] = "タグを削除できませんでした。"
          end
        end
      end
    else
      flash.now[:success] = "タグを選択してください"
    end
    set_tags
  end

  private

  def tags_params
    params.require(:tag).permit(:id, :question_body, :tag, :wcm)
  end

  def select_tags_params
    ids = params.fetch(:tag, {}).permit(tags_ids: [])
    ids.values[0]
  end

  def set_tags
    @will_tags = @current_user.tag.where(wcm: "will")
    @can_tags = @current_user.tag.where(wcm: "can")
    @must_tags = @current_user.tag.where(wcm: "must")
  end
end
