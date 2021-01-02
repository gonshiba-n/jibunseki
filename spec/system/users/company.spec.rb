require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
  let!(:user) { FactoryBot.create(:user) }
  let!(:company) { FactoryBot.create(:company, user: user) }

  describe "表示確認" do
    context "show" do
      it "検索バーが表示されていること"
      it "企業一覧テーブルが表示されていること"
      it "新規作成/削除ボタンが表示されていること"
    end

    context "create/delete_modal" do
      it "新規作成/削除ボタンを押すと新規作成/削除モーダルが開くこと"
      it "企業一覧テーブルが表示されていること"
      it "選択ボタンが表示されていること"
      it "選択ボタンを押すと削除と選択解除ボタンが表示れれること"
      it "選択ボタンを押すと企業一覧テーブルにチェックボックスが表示されること"
      it "作成ボタンが表示されていること"
      it "モーダルを閉じるボタンが表示されていること"
    end

    context "edit_modal" do
      it "テーブルセルをクリックすると編集がモーダルが開くこと"
      it "選択した企業の企業名が表示されていること"
      it "選択した企業のURLが表示されていること"
      it "選択した企業の事業内容が表示されていること"
      it "選択した企業の社風/環境表示されていること"
      it "選択した企業のビジョンが表示されていること"
      it "選択した企業の将来性が表示されていること"
      it "選択した企業のスキルが表示されていること"
      it "選択した企業の待遇が表示されていること"
      it "編集するボタンが表示されていること"
      it "閉じるボタンが表示されていること"
      context "編集ボタンを押して入力切り替え" do
        it "編集するボタンを押すと、入力画面に切り替わること"
        it "更新、キャンセルボタンが表示されていること"
        it "事業内容以降はマッチング度が表示されていること"
        it "入力切り替えは1つしか開けないこと"
      end

    end
  end

  context "有効なCRUD処理" do
    it "企業分析が作成できること"
    it "作成されたフラッシュが表示されること"
    it "企業分析の作成後にshowテーブルとモーダルのテーブルが更新されること"
    it "企業分析が削除できること"
    it "削除されたフラッシュが表示されること"
    it "企業分析の削除後にshowテーブルとモーダルのテーブルが更新されること"
    it "企業分析が更新できること"
    it "更新されたフラッシュが表示されること"
    it "企業分析の更新後にshowテーブルとモーダルのテーブルが更新されること"
  end

  context "無効なCRUD処理" do
    it "空白ならば、エラーを返すこと"
    it "企業名称が30文字を超えたらエラーを返すこと"
    it "URLはhttp(https):の形式でなければエラーを返すこと"
    it "事業内容以降は800文字を超えたらエラーを返すこと"
    it "選択せずに削除ボタンを押すとフラッシュが表示されること"
  end

end

# def click_create_modal
#   find("#achieve1").click
# end

# def click_edit_modal
#   find("#achieve1").click
# end
