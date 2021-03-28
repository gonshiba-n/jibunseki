require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
  let!(:user) { FactoryBot.create(:user) }
  let!(:company) { FactoryBot.create(:company, user: user) }

  before do
    login_for_app(user)
  end

  describe "表示確認" do
    context "show" do
      it "検索バーが表示されていること" do
        expect(page).to have_field "q[name_cont]"
      end
      it "企業一覧が表示されていること" do
        table = find(:xpath, '//table[@id = "company-show-table"]')
        expect(table).to have_content "MyString"
        expect(table).to have_link "URL"
      end
      it "新規作成/削除ボタンが表示されていること" do
        expect(page).to have_button "新規作成/削除"
      end
    end

    context "create/delete_modal" do
      before do
        click_create_modal
      end

      it "企業一覧テーブルが表示されていること" do
        table = find(:xpath, '//table[@id = "company-modal-table"]')
        expect(table).to have_content "MyString"
        expect(table).to have_link "URL"
      end
      it "削除選択ボタンが表示されていること" do
        expect(page).to have_button "削除選択"
      end
      it "選択ボタンを押すと削除と選択解除ボタンが表示れれること" do
        click_button "削除選択"
        expect(page).to have_button "解除"
        expect(page).to have_button "削除"
      end
      it "選択ボタンを押すと企業一覧テーブルにチェックボックスが表示されること" do
        click_button "削除選択"
        expect(page).to have_field "checkbox1"
      end
      it "作成ボタンが表示されていること" do
        expect(page).to have_button "作成"
      end
      it "モーダルを閉じるボタンが表示されていること" do
        expect(page).to have_button "閉じる"
      end
    end

    context "edit_modal" do
      before do
        click_edit_modal
      end

      it "選択した企業の企業名が表示されていること" do
        expect(company_edit_container).to have_content "MyString"
      end
      it "選択した企業のURLが表示されていること" do
        expect(company_edit_container).to have_content "https://jibunseki.herokuapp.com"
      end
      it "選択した企業の事業内容が表示されていること" do
        expect(company_edit_container).to have_content "MyBusiness"
        expect(company_edit_container).to have_content "MyCulture"
        expect(company_edit_container).to have_content "MyVision"
        expect(company_edit_container).to have_content "MyFuture"
        expect(company_edit_container).to have_content "MySkill"
        expect(company_edit_container).to have_content "MyTreatment"
      end
      it "編集するボタンが表示されていること" do
        expect(company_edit_container).to have_button "編集する"
      end
      it "閉じるボタンが表示されていること" do
        expect(page).to have_button "閉じる"
      end
      context "編集ボタンを押して入力切り替え" do
        it "編集するボタンを押すと、入力画面に切り替わること" do
          company_edit_container.all(".company-edit-button")[0].click
          expect(company_edit_container).to have_field "create-company-name"
          expect(company_edit_container).to have_button "更新"
          expect(company_edit_container).to have_button "キャンセル"
        end
        it "事業内容以降はマッチング度が表示されていること" do
          company_edit_container.all(".company-edit-button")[2].click
          expect(company_edit_container).to have_field "create-business-fit"
        end
        it "入力切り替えは1つしか開けないこと" do
          company_edit_container.all(".company-edit-button")[0].click
          company_edit_container.all(".company-edit-button")[1].click

          expect(company_edit_container).to have_field "create-company-business"
          expect(company_edit_container).to have_button "更新"
          expect(company_edit_container).to have_button "キャンセル"

          expect(company_edit_container).to have_selector "#nameForm", visible: false
        end
      end
    end
  end

  describe "有効なCRUD処理" do
    context "create" do
      before do
        click_create_modal
      end

      it "企業分析が作成でき、フラッシュが表示されること" do
        company_create_input

        expect(page).to have_content "株式会社じぶんセキを登録しました。"
      end
      it "企業分析の作成後にshowテーブルとモーダルのテーブルが更新されること" do
        company_create_input
        show_table = find "#company-show-table"
        modal_table = find "#company-modal-table"

        expect(show_table).to have_content "株式会社じぶんセキ"
        expect(modal_table).to have_content "株式会社じぶんセキ"
      end
      it "企業分析が削除できフラッシュが表示されること" do
        click_button "削除選択"
        check "checkbox1"
        click_button "削除"
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content "削除しました。"
      end
      it "企業分析の削除後にshowテーブルとモーダルのテーブルが更新されること" do
        click_button "削除選択"
        check "checkbox1"
        click_button "削除"
        page.driver.browser.switch_to.alert.accept
        show_table = find "#company-show-table"
        modal_table = find "#company-modal-table"

        expect(show_table).not_to have_content "MyString"
        expect(modal_table).not_to have_content "MyString"
      end
    end

    context "edit" do
      before do
        click_edit_modal
      end

      it "企業分析が更新できフラッシュが表示されること" do
        company_edit_container.all(".company-edit-button")[0].click
        fill_in "企業名:", with: "じぶんセキ株式会社"
        click_button "更新"

        expect(page).to have_content "じぶんセキ株式会社を更新しました。"
      end

      it "企業分析の更新後にshowテーブルとモーダルのテーブルが更新されること" do
        company_edit_container.all(".company-edit-button")[0].click
        fill_in "企業名:", with: "じぶんセキ株式会社"
        click_button "更新"

        show_table = find "#company-show-table"
        modal = find "#company-edit-content"

        expect(show_table).to have_content "じぶんセキ株式会社"
        expect(modal).to have_content "じぶんセキ株式会社"
      end
    end
  end

  describe "無効なCRUD処理" do
    context "create" do
      before do
        click_create_modal
      end

      it "空白ならば、エラーを返すこと" do
        click_button "作成"

        expect(page).to have_content "企業名を入力してください"
        expect(page).to have_content "URLを入力してください"
      end
      it "企業名称が30文字を超えたらエラーを返すこと" do
        fill_in "企業名:", with: "#{'a' * 31}"
        click_button "作成"

        expect(page).to have_content "企業名は30文字以内で入力してください"
      end
      it "URLはhttp(https):の形式でなければエラーを返すこと" do
        fill_in "URL",  with: "aaa"
        click_button "作成"

        expect(page).to have_content "URLは不正な値です"
      end
      it "事業内容以降は800文字を超えたらエラーを返すこと" do
        fill_in "事業内容", with: "#{'a' * 801}"
        click_button "作成"

        expect(page).to have_content "事業内容は800文字以内で入力してください"
      end
      it "選択せずに削除ボタンを押すとフラッシュが表示されること" do
        click_button "削除選択"
        click_button "削除"
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content "企業を選択してください。"
      end
    end

    context "edit" do
      before do
        click_edit_modal
      end

      it "企業名が空白ならば、エラーを返すこと" do
        company_edit_container.all(".company-edit-button")[0].click
        fill_in "企業名:", with: ""
        click_button "更新"

        expect(page).to have_content "企業名を入力してください"
      end
      it "URLが空白ならば、エラーを返すこと" do
        company_edit_container.all(".company-edit-button")[1].click
        fill_in "企業URL:", with: ""
        click_button "更新"

        expect(page).to have_content "URLを入力してください"
      end
      it "企業名称が30文字を超えたらエラーを返すこと" do
        company_edit_container.all(".company-edit-button")[0].click
        fill_in "企業名:", with: "#{'a' * 31}"
        click_button "更新"

        expect(page).to have_content "企業名は30文字以内で入力してください"
      end
      it "URLはhttp(https):の形式でなければエラーを返すこと" do
        company_edit_container.all(".company-edit-button")[1].click
        fill_in "企業URL:", with: "aaa"
        click_button "更新"

        expect(page).to have_content "URLは不正な値です"
      end
      it "事業内容以降は800文字を超えたらエラーを返すこと" do
        company_edit_container.all(".company-edit-button")[2].click
        fill_in "事業内容", with: "#{'a' * 801}"
        click_button "更新"

        expect(page).to have_content "事業内容は800文字以内で入力してください"
      end
    end
  end
end

def click_create_modal
  find("#company-create").click
end

def click_edit_modal
  find("#edit-company-id1").click
end

def company_edit_container
  find("#company-edit-modal")
end
# save_and_open_page
