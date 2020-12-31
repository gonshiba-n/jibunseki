class Companies::CompanySerachesController < ApplicationController
  def show
    respond_to do |format|
      format.js { render template: "users/companies/serach_company" }
    end
  end
end