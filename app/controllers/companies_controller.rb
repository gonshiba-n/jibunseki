class CompaniesController < ApplicationController
  def create
    @company = @current_user.company.new(companies_params)
    respond_to do |format|
      if @company.save
        format.js { flash.now[:success] = "#{@company.name}を登録しました。" }
      else
        format.js { render :create_errors }
      end
      set_instance
    end
  end

  def update
    @company = Company.find(companies_params[:id])
    if @company.update(companies_params)
      redirect_to user_path(@current_user.id), notice: "#{@company.name}を更新しました。"
    else
      redirect_to user_path(@current_user.id), notice: "更新できませんでした。"
    end
  end

  def destroy
    if select_companies_params.present?
      respond_to do |format|
        select_companies_params.each do |company|
          @company = @current_user.company.find(company)
          if @company.delete
            format.js { flash.now[:success] = "削除しました。" }
          else
            format.js { flash.now[:success] = "削除できませんでした。" }
          end
        end
      end
    else
      flash.now[:success] = "企業を選択してください。"
    end
    set_instance
  end

  private

  def companies_params
    params.require(:company).permit(:id,
                                    :name,
                                    :url,
                                    :business,
                                    :business_fit,
                                    :culture,
                                    :culture_fit,
                                    :vision,
                                    :vision_fit,
                                    :future,
                                    :future_fit,
                                    :skill,
                                    :skill_fit,
                                    :treatment,
                                    :treatment_fit,
                                  )
  end

  def select_companies_params
    ids = params.fetch(:company, {}).permit(companies_ids: [])
    ids.values[0]
  end

  def set_instance
    @companies = Company.where(user_id: @current_user.id)
  end
end
