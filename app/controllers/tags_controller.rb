class TagsController < ApplicationController
  def create
    @tag = @current_user.tag.new(tags_params)
    @tags = @current_user.tag.where(wcm: @tag.wcm)
    respond_to do |format|
      if @tag.save
        format.js { flash.now[:success] = "タグを作成しました。" }
      else
        format.js { render :create_errors }
      end
    end
  end

  def update
    @tag = @current_user.tag.find(tags_params[:id])
    @tags = @current_user.tag.where(wcm: @tag.wcm)
    respond_to do |format|
      if @tag.update(tags_params)
        format.js { flash.now[:success] = "タグを更新しました。" }
      else
        format.js { render :edit_errors }
      end
    end
  end

  def destroy
    if select_tags_params.present?
      select_tags = select_tags_params
      respond_to do |format|
        select_tags.each do |tag|
          tag = Tag.find(tag)
          @tags = @current_user.tag.where(wcm: tag.wcm)
          if tag.destroy
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
  end

  def page_transition
    @tag = @current_user.tag.new
    @transition_value = params[:transition_value]
    @tags = @current_user.tag.where(wcm: @transition_value)
    respond_to do |format|
      if @transition_value == "will" || @transition_value == "can" || @transition_value == "must"
        format.js { render template: "users/ajax/transition_destination"}
      else
        render template: "users/show"
        flash.now[:success] = "不正な遷移指定です"
      end
    end
  end

  private

  def tags_params
    params.require(:tag).permit(:id, :question_body, :tag, :wcm)
  end

  def select_tags_params
    ids = params.fetch(:tag, {}).permit(tags_ids: [])
    ids.values[0]
  end
end
