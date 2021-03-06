require 'rails_helper'

@text = "私は〇〇をしたい。その理由は、〇〇である。(Willベースタグ)
        今まで、～～という経験をしてきた。～～といったスキルもある。(Canベースタグ)
        今後は～～することが求められる。そうしたスキル・経験を身に付けて行動していく。(Mustベースタグ)"

RSpec.describe "Users", type: :system, js: true do
  describe "show wcmシート" do
    let!(:user) { FactoryBot.create(:user) }

    before do
      @will_tag = FactoryBot.create(:tag, user: user)
      @can_tag = FactoryBot.create(:tag, :can, user: user)
      @must_tag = FactoryBot.create(:tag, :must, user: user)
      login_for_app(user)
    end

    describe "WCMシート" do
      it "タグが存在していること" do
        expect(page).to have_selector(".will-tag a")
      end

      it "ベースタグが表示されていること" do
        expect(page).to have_selector(".base-tag")
      end

      it "wcmタグをクリックするとタグ編集モーダルが表示されること" do
        click_modal
        expect(page).to have_content "WCMタグ作成・編集"
      end

      it "ベースタグをクリックするとベースタグ、行動指標の編集モーダルが表示されること" do
        click_modal_base_tag
        expect(page).to have_content "ベースタグの編集・行動指針の編集"
      end

      it "選択ボタンがあること" do
        click_modal
        expect(page).to have_button "選択"
      end

      it "選択ボタンを押すと削除ボタンが出ること" do
        click_modal
        click_button "選択"
        expect(page).to have_button "削除"
      end

      it "選択ボタンを押すとボタンのテキストが選択から解除に変化すること" do
        click_modal
        click_button "選択"
        btn = find_by_id("select-btn")
        expect(btn).to have_attributes(value: "解除")
      end

      it "選択ボタンを押すとタグの横にチェックボックスが出ること" do
        click_modal
        click_button "選択"
        expect(page).to have_field("tag1")
      end

      it "編集タグはnoneタグになっていること" do
        click_modal
        expect(page).to have_button "none"
      end

      it "編集の更新のボタンが存在していること" do
        click_modal
        expect(page).to have_button "更新", disabled: true
      end

      it "タグを選択すると更新ボタンが有効になること" do
        click_modal
        click_button "will_tag"
        expect(page).to have_button "更新"
      end

      it "タグを選択すると編集タグが選択タグに切り替わること" do
        click_modal
        click_button "will_tag"
        edit_tag = find("#blank-tag-container button")
        textarea = find("#edit-textarea")
        textfield = find("#edit-textfield")
        expect(edit_tag).to have_content "#{@will_tag.tag}"
        expect(textarea.value).to match "#{@will_tag.question_body}"
        expect(textfield.value).to match "#{@will_tag.tag}"
        expect(page).to have_button "更新"
      end

      it "showページのベースタグが登録されていなければnoneタグが表示されていること" do
        will_base = find("#base-will")
        can_base = find("#base-can")
        must_base = find("#base-must")
        expect(will_base).to have_content "none"
        expect(can_base).to have_content "none"
        expect(must_base).to have_content "none"
      end

      it "行動指標が登録されていなければデフォルトの行動指標が表示されていること" do
        container = find("#guideline-container")
        expect(container).to have_content @text
      end

      it "モーダルのテキストエリアに行動指標が表示されていること" do
        click_modal_base_tag
        area = find("#guideline-area")
        expect(area.value).to have_content @text
      end

      it "行動指標クリアボタンを押すとテキストエリアが空になること" do
        click_modal_base_tag
        area = find("#guideline-area")
        click_button "クリア"
        expect(area.value).to have_content ""
      end

      it "閉じるボタンが存在していること" do
        click_modal
        expect(page).to have_button "閉じる"
      end

      context "有効なタグCRUD処理" do
        it "タグが作成されること" do
          click_modal
          fill_in "質問の新規作成", with: "NewQuestion"
          fill_in "解答タグの新規作成", with: "NewTag"
          click_button "作成"
          expect(page).to have_button "NewTag"
          expect(page).to have_content "タグを作成しました。"
        end

        it "タグの更新後に表示タグと編集タグが更新後の値に変化すること" do
          click_modal
          click_button "will_tag"
          fill_in "edit-textfield", with: ""
          fill_in "edit-textfield", with: "update_tag"
          click_button "更新"
          show_tag = find(".tags-container .show-btn")
          edit_tag = find("#blank-tag-container button")
          sleep 0.5
          expect(page).to have_content "タグを更新しました。"
          expect(show_tag).to have_content "update_tag"
          expect(edit_tag).to have_content "update_tag"
        end

        it "削除ボタンを押すと削除されること" do
          click_modal
          click_button "選択"
          check "tag1"
          click_button "削除"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "タグを削除しました。"
          expect(page).not_to have_button "will_tag"
        end

        it "ベースタグを登録するとフラッシュが表示されること" do
          click_modal_base_tag
          sleep 0.5
          first(".will-check").click
          click_button "ベースタグを更新"
          expect(page).to have_content "ベースタグをアップデートしました。"
        end

        it "ベースタグを登録するとshowページに反映されること" do
          click_modal_base_tag
          sleep 0.5
          first(".will-check").click
          click_button "ベースタグを更新"
          show_tag = find("#base-will")
          expect(show_tag).to have_content "will_tag"
        end

        it "行動指針を登録するとフラッシュが表示されること" do
          click_modal_base_tag
          fill_in "行動指針の編集:", with: "行動指針のテスト"
          click_button "行動指針を更新"
          expect(page).to have_content "行動指針を作成しました。"
        end

        it "行動指針を登録するとshowページに反映されること" do
          click_modal_base_tag
          container = find("#guideline-container")
          fill_in "行動指針の編集:", with: "行動指針のテスト"
          click_button "行動指針を更新"
          click_button "閉じる"
          expect(container).to have_content "行動指針のテスト"
        end

        it "行動指針を更新すると編集モーダルに反映されること" do
          click_modal_base_tag
          container = find("#guideline-modal-container")
          fill_in "行動指針の編集:", with: "行動指針のテスト"
          click_button "行動指針を更新"
          expect(container).to have_content "行動指針のテスト"
        end
      end

      context "無効なタグCRUD処理" do
        it "タグが作成されずにエラー文を返すこと" do
          click_modal
          fill_in "質問の新規作成", with: ""
          fill_in "解答タグの新規作成", with: ""
          click_button "作成"
          expect(page).to have_content "質問文を入力してください"
          expect(page).to have_content "タグを入力してください"
        end

        it "作成タグ入力が１０文字を超えないこと" do
          click_modal
          fill_in "質問の新規作成", with: "NewQuestion"
          fill_in "解答タグの新規作成", with: "#{"a" * 11}"
          click_button "作成"
          expect(page).to have_content "タグは10文字以内で入力してください"
        end

        it "空白ならタグの更新せずにエラーを返すこと" do
          click_modal
          click_button "will_tag"
          fill_in "edit-textarea", with: ""
          fill_in "edit-textfield", with: ""
          click_button "更新"
          expect(page).to have_content "質問文を入力してください"
          expect(page).to have_content "タグを入力してください"
        end

        it "編集タグ入力が１０文字を超えないこと" do
          click_modal
          click_button "will_tag"
          fill_in "edit-textarea", with: "NewQuestion"
          fill_in "edit-textfield", with: "#{"a" * 11}"
          click_button "更新"
          expect(page).to have_content "タグは10文字以内で入力してください"
        end

        it "選択せずに削除ボタンを押すとエラーを返すこと" do
          click_modal
          click_button "選択"
          click_button "削除"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "タグを選択してください"
        end

        it "ベースタグを選択しないとフラッシュが表示されること" do
          click_modal_base_tag
          click_button "ベースタグを更新"
          expect(page).to have_content "ベースタグを選択してください"
        end

        it "行動指標を空白で登録するとエラーを返すこと" do
          click_modal_base_tag
          fill_in "行動指針の編集:", with: ""
          click_button "行動指針を更新"
          expect(page).to have_content "行動指針を入力してください"
        end
      end
    end
  end
end

def click_modal
  click_link "will_tag"
end

def click_modal_base_tag
  find("#base-will").click
end
