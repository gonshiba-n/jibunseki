class Tags::PageTransitionsController < ApplicationController

  def show
    @tag = @current_user.tag.new
    @transition_value = params[:transition_value]
    @tags = @current_user.tag.tags(@transition_value)
    respond_to do |format|
      if @transition_value == "will" || @transition_value == "can" || @transition_value == "must"
        format.js { render template: "users/wcm_seat/modal/transition_destination" }
      else
        render template: "users/show"
        flash.now[:success] = "不正な遷移指定です"
      end
    end
  end

end