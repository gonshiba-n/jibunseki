class Companies::CompanySerachesController < ApplicationController
  def index
    @sort_companies = @q.result
    respond_to do |format|
      format.js { render template: "users/companies/sort_companies" }
    end
  end

  def show
    respond_to do |format|
      format.js { render template: "users/companies/serach_companies" }
    end
  end
end