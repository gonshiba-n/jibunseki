class Targets::TargetTransitionsController < ApplicationController
  def show
    @target = @current_user.target.new
    @value = params[:transition_value]
    if @value == "long" || @value == "middle" || @value == "short"
      @targets = @current_user.target.where(period: @value)
    else
      @targets = @current_user.target.all
    end
    respond_to do |format|
      if @value == "index" || @value == "long" || @value == "middle" || @value == "short"
        format.js { render template: "users/target/modal/transition_destination" }
      else
        format.js { render template: "users/target/modal/transition_destination" }
        flash.now[:success] = "不正な操作が検出されました。"
      end
    end
  end
end
