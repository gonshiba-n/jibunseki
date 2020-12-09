class Targets::PageTransitionsController < ApplicationController
  def show
    @target = @current_user.target.new
    @transition_value = params[:transition_value]
    @targets = @current_user.target.period(@transition_value)
    respond_to do |format|
      if @transition_value == "long" || @transition_value == "middle" || @transition_value == "short"
        # format.js { render template: "users/wcm_seat/modal/transition_destination" }
      else
        render template: "users/show"
        flash.now[:success] = "不正な遷移指定です"
      end
    end
  end
end
