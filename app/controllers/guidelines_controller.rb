class GuidelinesController < ApplicationController
  def create
    respond_to do |format|
      case Guideline.exists?(user_id: @current_user.id)
      when false
        @guideline = Guideline.new(guideline_params)
        if @guideline.save(context: :user)
          format.js {flash.now[:success] = "行動指針を作成しました。"}
        else
          format.js { render :create_errors }
        end
      when true
        @guideline = Guideline.find_by(user_id: @current_user.id)
        if @guideline.update(guideline_params)
          format.js {flash.now[:success] = "行動指針をアップデートしました。"}
        else
          format.js{render :create_errors}
        end
      else
        redirect_to root_path, notice: "不正な操作がされました。"
      end
    end
  end

  private

  def guideline_params
    params.require(:guideline).permit(:text).merge(user_id: @current_user.id)
  end
end
