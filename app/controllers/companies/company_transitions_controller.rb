class Companies::CompanyTransitionsController < ApplicationController
  def show
    @company = @current_user.company.find(params[:transition_value])
    respond_to do |format|
      format.js { render template: "users/companies/modal/edit/_transition_dstination" }
    end
  end
end
