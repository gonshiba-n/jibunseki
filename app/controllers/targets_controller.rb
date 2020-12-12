class TargetsController < ApplicationController
  def create
    @target = @current_user.target.new(targets_params)

    if @target.save
      redirect_to root_path, notice: "#{@target.target_body}を目標に設定しました。"
    else
      redirect_to root_path, notice: "目標を作成できませんでした。"
    end
  end

  def update
    @target = @current_user.target.find(targets_params[:id])
    if @target.update(targets_params)
      redirect_to root_path, notice: "#{@target.target_body}を更新しました。"
    else
      redirect_to root_path, notice: "目標を更新できませんでした。"
    end
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
end
