class CompaniesController < ApplicationController
  def create
    @campany = @current_user.company.new(targets_params)
    if @campany.save
      redirect_to user_path(@current_user.id), notice: "#{@company.name}の登録が完了しました。"
    else
      redirect_to user_path(@current_user.id), notice: "登録ができませんでした。"
    end
  end

  private

  def targets_params
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
end
