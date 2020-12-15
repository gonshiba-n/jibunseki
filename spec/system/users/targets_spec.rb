require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
  describe "show wcmを基にした目標" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:target) { FactoryBot.create(:target, user: user) }

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
    it "目標を選択しなければ、編集ボタンを押せないこと"

    context "有効なCRUD処理" do
      before do
        click_taget_modal
      end

      it "目標が登録されること" do
        fill_in "create-target-body",	with: "NewTarget"
        fill_in "create-start",	with: "00202012010000"
        fill_in "create-deadline",	with: "00202012300000"
        select "短期目標", from: "create-period"
        click_button "作成"
        expect(page).to have_content "NewTargetを作成しました。"
      end

      it "登録後にモーダルに表示されること" do
        fill_in "create-target-body",	with: "New target"
        fill_in "create-start",	with: "00202012010000"
        fill_in "create-deadline",	with: "00202012300000"
        select "短期目標", from: "create-period"
        click_button "作成"
        div = find(:xpath, '//div[@class = "target-container"]')
        expect(div).to have_content "New target"
      end

      it "登録後にshowページに表示されること" do
        fill_in "create-target-body",	with: "NewTarget"
        fill_in "create-start",	with: "00202012010000"
        fill_in "create-deadline",	with: "00202012300000"
        select "短期目標", from: "create-period"
        click_button "作成"
        click_button "閉じる"
        div = find(:xpath, '//div[@id = "targetShowContainer"]')
        expect(div).to have_content "NewTarget"
      end

      it "目標が編集できること" do
        click_button "未達成"
        fill_in "target_target_body", with: "EditString"
        click_button "更新"
        expect(page).to have_content "EditStringを更新しました。"
      end

      it "編集後にモーダルに表示されること" do
        click_button "未達成"
        fill_in "target_target_body", with: "EditString"
        click_button "更新"
        click_button "閉じる"
        div = find(:xpath, '//div[@class = "target-container"]')
        expect(div).to have_content "EditString"
      end

      it "編集後にshowページに表示されること" do
        click_button "未達成"
        fill_in "target_target_body", with: "EditString"
        click_button "更新"
        click_button "閉じる"
        div = find(:xpath, '//div[@id = "targetShowContainer"]')
        expect(div).to have_content "EditString"
      end

      it "目標を削除できること" do
        click_button "選択"
        check "MyString"
        click_button "削除"
        expect(page).to have_content "目標を削除しました。"
        expect(page).to_not have_content "MyString"
      end

      it "削除後にshowページに表示されていないこと" do
        click_button "選択"
        check "MyString"
        click_button "削除"
        click_button "閉じる"
        expect(page).to_not have_content "MyString"
      end

    end

    context "無効なCRUD処理" do
      before do
        click_taget_modal
      end

      it "空白ならば目標が登録されずにエラーを返すこと" do
        fill_in "create-target-body", with: ""
        fill_in "create-start", with: ""
        fill_in "create-deadline", with: ""
        click_button "作成"
        expect(page).to have_content "目標文を入力してください"
        expect(page).to have_content "目標開始日時を入力してください"
        expect(page).to have_content "目標達成予定日時を入力してください"
      end

      it "目標の設定が51文字以上ならばエラーを返すこと" do
        fill_in "create-target-body", with: "#{"a" * 51}"
        fill_in "create-start", with: "00202012010000"
        fill_in "create-deadline", with: "00202012300000"
        click_button "作成"
        expect(page).to have_content "目標文は50文字以内で入力してください"
      end

      it "新規作成にて目標開始日時よりも達成予定日時が前に設定された場合エラーを返すこと" do
        fill_in "create-target-body", with: "NewTarget"
        fill_in "create-start", with: "00202012300000"
        fill_in "create-deadline", with: "00202012010000"
        click_button "作成"
        expect(page).to have_content "目標開始日時は、目標達成予定日時よりも前に設定してください。"
      end

      it "編集にて目標開始日時よりも達成予定日時が前に設定された場合エラーを返すこと" do
        click_button "未達成"
        fill_in "target_start", with: "00202012300000"
        fill_in "target_deadline", with: "00202012010000"
        click_button "更新"
        expect(page).to have_content "目標開始日時は、目標達成予定日時よりも前に設定してください。"
      end

      it "選択せずに削除ボタンを押すとフラッシュが表示されること" do
        click_button "選択"
        click_button "削除"
        expect(page).to have_content "目標を選択してください。"
      end

    end
  end
end

def click_taget_modal
  find(".target").click
end
