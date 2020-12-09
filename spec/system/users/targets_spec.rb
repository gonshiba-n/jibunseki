require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
  describe "show wcmを基にした目標" do
    let(:user) { FactoryBot.create(:user) }
    before do
      login_for_app(user)
    end

    it "選択されたプログレスバーが表示されていること"
    it "プログレスバーが適切な進捗状況を表していること"
    it "長期目標が表示されていること"
    it "中期目標が表示されていること"
    it "長短期目標が表示されていること"
    it "目標達成ボタンが表示されていること"
    it "目標未達成ボタンが表示されていること"
    it "編集モーダルが開くこと"

    context "有効なCRUD処理" do
      it "目標が登録されること"
      it "登録後にshowページに表示されること"
      it "登録後にモーダルに表示されること"
      it "目標が編集できること"
      it "編集後にshowページに表示されること"
      it "編集後にモーダルに表示されること"
      it "目標を削除できること"
      it "削除後にshowページに表示されていないこと"
      it "削除後にモーダルに表示されていないこと"
    end

    context "無効なCRUD処理" do
      it "空白ならば目標が登録されずにエラーを返すこと"
    end
  end
end
