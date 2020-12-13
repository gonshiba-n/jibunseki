class TargetsController < ApplicationController
  def create
    @target = @current_user.target.new(targets_params)
    respond_to do |format|
      if @target.save
        format.js { flash.now[:success] = "#{@target.target_body}目標を作成しました。" }
      else
        format.js { render :create_errors }
      end
    end
    set_instance
  end

  def update
    @target = @current_user.target.find(targets_params[:id])
    respond_to do |format|
      if @target.update(targets_params)
        format.js { flash.now[:success] = "#{@target.target_body}目標を更新しました。" }
      else
        format.js { render :update_errors }
      end
    end
    set_instance
  end

  def destroy
    if select_targets_params.present?
      select_targets_params.each do |id|
        @target = @current_user.target.find(id)
        @target.delete
      end
      redirect_to root_path, notice: "目標を削除しました。"
    else
      redirect_to root_path, notice: "削除項目を選択してください。"
    end
  end

  private

  def targets_params
    params.require(:target).permit(:id, :target_body, :start, :deadline, :achieve, :period)
  end

  def select_targets_params
    ids = params.fetch(:target, {}).permit(targets_ids: [])
    ids.values[0]
  end

  def set_instance
    @tag = Tag.new
    @will_tags = @current_user.tag.where(wcm: "will")
    @can_tags = @current_user.tag.where(wcm: "can")
    @must_tags = @current_user.tag.where(wcm: "must")
    @will_base = @current_user.tag.find_by(wcm: "will", base_tag: true)
    @can_base = @current_user.tag.find_by(wcm: "can", base_tag: true)
    @must_base = @current_user.tag.find_by(wcm: "must", base_tag: true)
    @guideline = Guideline.find_or_initialize_by(user_id: @current_user.id).presence || Guideline.new
    @targets = Target.where(user_id: @current_user)
  end
end
