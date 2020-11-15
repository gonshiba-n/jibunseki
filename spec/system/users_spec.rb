require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
  describe "new ユーザー登録ページ" do
    before do
      visit new_user_path
    end

    describe "表示確認" do
      it "Signupの文字列が表示されていること" do
        expect(page).to have_content 'Signup'
      end
    end

    describe "ユーザー登録機能" do
      context "有効なユーザー" do
        it "ユーザー登録が行われること" do
          fill_in "ユーザー名", with: "test_user"
          fill_in "メールアドレス", with: "test@test.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再確認", with: "password"
          click_button "Signup"
          @user = User.find_by(name: 'test_user')
          expect(current_path).to eq user_path(@user.id)
          expect(page).to have_selector '.alert', text: "#{@user.name}さん！登録が完了しました。"
        end
      end

      context "無効なユーザー" do
        it "ユーザー登録が行われずに、エラー分が返されること" do
          fill_in "ユーザー名", with: " "
          fill_in "メールアドレス", with: " "
          fill_in "パスワード", with: " "
          fill_in "パスワード再確認", with: " "
          click_button "Signup"
          expect(page).to have_content "名前を入力してください"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(page).to have_content "メールアドレスは不正な値です"
          expect(page).to have_content "パスワードは6文字以上で入力してください"
        end
      end

      it "passwordが一致しなければエラー文が返されること" do
        fill_in "ユーザー名", with: "test_user"
        fill_in "メールアドレス", with: "test@test.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード再確認", with: "password_confirmation"
        click_button "Signup"

        expect(page).to have_content "再確認用パスワードとパスワードの入力が一致しません"
      end
    end
  end

  describe "show ユーザーワークスペース" do
    let!(:user) { FactoryBot.create(:user) }

    before do
      @will_tag = FactoryBot.create(:tag, user: user)
      @can_tag = FactoryBot.create(:tag, :can, user: user)
      @must_tag = FactoryBot.create(:tag, :must, user: user)
      login_for_app(user)
    end

    it "ユーザー名が表示れていること" do
      expect(page).to have_content user.name
    end

    it "ログアウトリンクが表示れていること" do
      expect(page).to have_link "Logout"
    end

    describe "WCMシート" do
      it "タグが存在していること" do
        expect(page).to have_selector(".will-tag button")
      end

      it "ベースタグが表示されていること" do
        expect(page).to have_selector(".base-tag button")
      end

      it "タグをクリックするとモーダルが表示されること" do
        click_modal
        expect(page).to have_content "WCMタグ編集"
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
          expect(page).not_to have_content "will_tag"
          expect(page).to have_content "タグを削除しました。"
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

        it "タグの更新がエラーになりエラーを返すこと" do
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

        it "削除ボタンを押すと削除されること" do
          click_modal
          click_button "選択"
          click_button "削除"
          expect(page).to have_content "タグを選択してください"
        end
      end
    end
  end
end

def click_modal
  click_link "primary1"
end

# save_and_open_page
