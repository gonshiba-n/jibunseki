require 'rails_helper'
include Tags::QuestionAssistancesHelper

RSpec.describe "Tag::QuestionAssistances", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  describe "wcm_easy_outputs" do
    before do
      login_for_app(user)
      visit new_question_assistances_path(user.id)
    end

    it "画面遷移に成功していること" do
      expect(page).to have_content "Will,Can,Mustに沿った質問に答えてカンタンに単語をアウトプットしましょう"
    end

    it "nextボタンが機能していること" do
      next_btn
      expect(page).to have_content"あなたは将来、なりたいものはありますか？"
    end

    it "prevボタンが機能していること" do
      prev_btn
      expect(page).to have_content"おつかれさまでした！"
    end

    it "質問と解答タグ:の例が正しく表示されていること" do
      next_btn
      expect(questions.keys[0]).to have_content "理想の将来像を入力しましょう"
      expect(questions.values[0]).to have_content "あなたは将来、なりたいものはありますか？"
    end

    it "作成ボタンが表示されていること" do
      next_btn
      expect(page).to have_button "作成"
    end

    it "インジケータの数はindicators_countメソッド通りの数となっていること" do
      indicators = all(".carousel-indicators li").count
      expect(indicators).to eq indicators_count + 1
    end

    it "質問と設定しているタグがany_of_wcmメソッドを使用して、表示されていること" do
      next_btn
      expect(page).to have_button "will"
      find("#indicators5").click
      expect(page).to have_button "can"
      find("#indicators9").click
      expect(page).to have_button "must"
    end

    it "最終ページに戻るボタンが表示されていること" do
      prev_btn
      expect(page).to have_link "戻る"
    end

    context "create" do
      it "タグ作成後、フラッシュが表示されること" do
        next_btn
        fill_in "解答タグ: #{questions.keys[0]}",	with: "text"
        click_button "作成"
        expect(page).to have_content "タグを作成しました。"
      end

      it "タグ入力エラー表示後、nextボタンを押すと入力エラー表示が消えること" do
        next_btn
        fill_in "解答タグ: #{questions.keys[0]}",	with: "text"
        click_button "作成"
        flash = find(".alert-success")
        next_btn
        expect(page).to_not have_content "タグを作成しました。"
      end

      it "タグ作成後、prevボタンを押すとフラッシュが消えること" do
        next_btn
        fill_in "解答タグ: #{questions.keys[0]}",	with: "text"
        click_button "作成"
        flash = find(".alert-success")
        prev_btn
        expect(page).to_not have_content "タグを作成しました。"
      end

      it "作成後、ワークスペースに反映されていること" do
      next_btn
      fill_in "解答タグ: #{questions.keys[0]}",	with: "text"
      click_button "作成"
      visit root_path
      expect(page).to have_link "text"
      end
    end

    context "errors" do
      it "タグが空白ならエラー文を返すこと" do
        next_btn
        fill_in "解答タグ: #{questions.keys[0]}",	with: ""
        click_button "作成"
        expect(page).to have_content "タグを入力してください"
      end

      it "タグが10文字を超えないこと" do
        next_btn
        fill_in "解答タグ: #{questions.keys[0]}",	with: "#{'a' * 11}"
        click_button "作成"
        expect(page).to have_content "タグは10文字以内で入力してください"
      end

      it "wcm各タグが６個を超えたらエラー文を返すこと" do
        next_btn
        7.times do
          fill_in "解答タグ: #{questions.keys[0]}",	with: "a"
          click_button "作成"
        end
        expect(page).to have_content "Will,Can,Mustのタグの登録は、それぞれ６件までです"
      end
    end
  end

  def next_btn
    find("#next").click
  end

  def prev_btn
    find("#prev").click
  end
end
