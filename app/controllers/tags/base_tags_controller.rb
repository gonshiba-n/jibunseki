class Tags::BaseTagsController < ApplicationController

  def create
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

  private

  def base_tag_params
    ids = params.fetch(:tag, {}).permit(base_tag: [])
    ids.values[0]
  end

  def set_tags
    @will_tags = @current_user.tag.recent("will")
    @can_tags = @current_user.tag.recent("can")
    @must_tags = @current_user.tag.recent("must")
    @will_base = @current_user.tag.base("will")
    @can_base = @current_user.tag.base("can")
    @must_base = @current_user.tag.base("must")
end

end
