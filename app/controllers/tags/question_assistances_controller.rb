class Tags::QuestionAssistancesController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = @current_user.tag.build(assistances_tags_params)
    respond_to do |format|
      if @tag.save
        format.js { flash.now[:notice] = "タグを作成しました。" }
      else
        format.js { render :create_errors }
      end
    end
  end

  def update

  end

  private

  def assistances_tags_params
    params.require(:tag).permit(:id, :question_body, :tag, :wcm)
  end
end