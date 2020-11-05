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
      will_tag = FactoryBot.create(:tag, user: user)
      can_tag = FactoryBot.create(:tag, :can, user: user)
      must_tag = FactoryBot.create(:tag, :must, user: user)
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

      it "Willタグの色が適性であること"

      it "Canタグの色が適性であること"

      it "Mustタグの色が適性であること"

      it "ベースタグが表示されていること" do
        expect(page).to have_selector(".base-tag button")
      end

      it "WCM行動指標が行事されていること"

      it "他ユーザーのWCMリンクが存在すること"

      # モーダル
      it "タグをクリックするとモーダルが表示されること" do
        click_modal
        expect(page).to have_content "WCMタグ編集"
      end

      it "WillページにはCan,Mustタグは存在しないこと" do
        click_modal
        click_link "Will"
        expect(page).to have_button "will_tag"
        expect(page).to have_no_button "can_tag"
        expect(page).to have_no_button "must_tag"
      end

      it "CanページにはWill,Mustタグは存在しないこと"

      it "MustページにはWill,Canタグは存在しないこと"

      it "選択削除ボタンがあること" do
        click_modal
        expect(page).to have_link "選択削除"
      end

      it "編集タグはnoneタグになっていること"

      it "タグを選択すると編集タグが選択タグに切り替わること"

      it "編集のテキストエリアが表示されていること"

      it "編集の解答タグのテキストフィールドが存在していること"

      it "編集の更新のボタンが存在していること" do
        click_modal
        expect(page).to have_button "更新"
      end
      # 有効なタグ編集
      # 無効ななタグ編集

      it "新規作成の質問テキストエリアが表示されていること"

      it "新規作成の解答タグテキストフィールドが存在していること"

      it "保存ボタンが存在していること" do
        click_modal
        expect(page).to have_button "保存"
      end

      it "キャンセルボタンが存在していること" do
        click_modal
        expect(page).to have_button "キャンセル"
      end

      context "有効なタグ登録" do
        it "タグが作成されること" do
          click_modal
          fill_in "質問の新規作成", with: "NewQuestion"
          fill_in "解答タグの新規作成", with: "NewTag"
          click_button "作成"
          @tag = user.tag.find_by(tag: 'NewTag')
          click_modal
          expect(page).to have_content(@tag.tag)
        end
      end

      # 無効なタグ登録
      context "無効なタグ作成" do
        it "タグが作成されずにエラー文を返すこと"
      end
    end
  end
end

def click_modal
  click_button "primary1"
end
