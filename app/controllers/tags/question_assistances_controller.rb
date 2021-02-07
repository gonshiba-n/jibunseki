class Tags::QuestionAssistancesController < ApplicationController
  def new
    @tags = Tag.new
  end

  def create
    @tags = @current_user.tag.build(assistances_tags_params)
    @tags.save
  end

  def update

  end

  private

  def assistances_tags_params
    params.require(:tag).permit(:id, :question_body, :tag, :wcm)
  end
end
