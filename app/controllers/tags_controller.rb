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
    @tags = @current_user.tag.where(wcm: @tag.wcm)
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
    @tags = @current_user.tag.where(wcm: @tag.wcm)
    set_tags
  end

  def destroy
    if select_tags_params.present?
      select_tags = select_tags_params
      respond_to do |format|
        select_tags.each do |tag|
          tag = Tag.find(tag)
          @value = tag.wcm
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
      @transition_value = params[:transition_value]
      @tags = @current_user.tag.where(wcm: @transition_value)
      flash.now[:success] = "タグを選択してください"
    end
    set_tags
  end

  def update_base_tag
    new_base_tag = base_tag_params
    old_base_tag = @current_user.tag.where(base_tag: true)
    respond_to do |format|
      if new_base_tag
        old_base_tag.update(base_tag: false)
        new_base_tag.each do |id|
          tag = Tag.find(id)
          tag.update(base_tag: true)
            format.js { flash.now[:success] = "ベースタグをアップデートしました。" }
        end
      else
        format.js { flash.now[:success] = "ベースタグを選択してください" }
      end
      set_tags
    end
  end

  def page_transition
    @tag = @current_user.tag.new
    @transition_value = params[:transition_value]
    @tags = @current_user.tag.where(wcm: @transition_value)
    respond_to do |format|
      if @transition_value == "will" || @transition_value == "can" || @transition_value == "must"
        format.js { render template: "users/wcm_seat/modal/transition_destination" }
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

  def base_tag_params
    ids = params.fetch(:tag, {}).permit(base_tag: [])
    ids.values[0]
  end

  def set_tags
    @will_tags = @current_user.tag.where(wcm: "will")
    @can_tags = @current_user.tag.where(wcm: "can")
    @must_tags = @current_user.tag.where(wcm: "must")
    @will_base = @current_user.tag.find_by(wcm: "will", base_tag: true)
    @can_base = @current_user.tag.find_by(wcm: "can", base_tag: true)
    @must_base = @current_user.tag.find_by(wcm: "must", base_tag: true)
  end
end
