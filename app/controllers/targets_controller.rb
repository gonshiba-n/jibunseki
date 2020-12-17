class TargetsController < ApplicationController
  def create
    @target = @current_user.target.new(targets_params)
    respond_to do |format|
      if @target.save
        format.js { flash.now[:success] = "#{@target.target_body}を作成しました。" }
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
        format.js { flash.now[:success] = "#{@target.target_body}を更新しました。" }
      else
        format.js { render :update_errors }
      end
    end
    set_instance
  end

  def destroy
    if select_targets_params.present?
      respond_to do |format|
        select_targets_params.each do |id|
          @target = @current_user.target.find(id)
          if @target.delete
            format.js { flash.now[:success] = "目標を削除しました。"  }
          else
            format.js { flash.now[:success] = "目標を削除できませんでした。"  }
          end
        end
      end
    else
      flash.now[:success] = "目標を選択してください。"
    end
    set_instance
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
    @targets = Target.where(user_id: @current_user).time_order
  end
end
