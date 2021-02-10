require 'rails_helper'

RSpec.describe "QuestionAssistances", type: :system do
  describe "wcm_easy_outputs" do
    before do
      login_for_app(user)
      visit new_question_assistances_path
    end

    it "質問はquestions_countメソッド通りの表示となっていること"
    it "インジケータの数はindicators_countメソッド通りの数となっていること"
    it "questionsメソッドのハッシュから質問と解答タグが表示されていること"
    it "質問と設定しているタグがany_of_wcmメソッドを使用して、表示されていること"
    it "nextボタンを押すとページが送られること"
    it "タグ作成後、nextボタンを押すとフラッシュが消えること"
    it "タグ入力エラー表示後、nextボタンを押すと入力エラー表示が消えること"
    it "prevボタンを押すとページが送られること"
    it "タグ作成後、prevボタンを押すとフラッシュが消えること"
    it "タグ入力エラー表示後、prevボタンを押すと入力エラー表示が消えること"
    it "作成ボタンが表示されていること"
    it "最終ページに戻るボタンが表示されていること"

    context "create" do
      it "タグが作成されること"
      it "作成後フラッシュが表示されること"
      it "作成後、ワークスペースに反映されていること"
      it "作成後、WCM編集に反映されていること"
    end

    context "errors" do
      it "タグが空白ならエラー文を返すこと"
      it "タグが10文字を超えないこと"
      it "wcm各タグが６個を超えたらエラー文を返すこと"
    end
  end
  #リクエストテストで中身を解析
end
