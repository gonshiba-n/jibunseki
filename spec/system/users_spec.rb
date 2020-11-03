require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "new ユーザー登録ページ" do
    before do
      visit new_user_path
    end

    context "表示確認" do
      it "Signupの文字列が表示されていること" do
        expect(page).to have_content 'Signup'
      end
    end

    context "ユーザー登録機能" do
      it "正常なユーザー登録処理" do
        fill_in "ユーザー名",	with: "test_user"
        fill_in "メールアドレス",	with: "test@test.com"
        fill_in "パスワード",	with: "password"
        fill_in "パスワード再確認",	with: "password"
        click_button "Signup"

        @user = User.find_by(name: 'test_user')
        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_selector '.alert', text: "#{@user.name}さん！登録が完了しました。"
      end

      it "異常なユーザー登録処理" do
        fill_in "ユーザー名",	with: " "
        fill_in "メールアドレス",	with: " "
        fill_in "パスワード",	with: " "
        fill_in "パスワード再確認",	with: " "
        click_button "Signup"

        expect(page).to have_content "名前を入力してください"
        expect(page).to have_content "メールアドレスを入力してください"
        expect(page).to have_content "メールアドレスは不正な値です"
        expect(page).to have_content "パスワードは6文字以上で入力してください"
      end

      it "password一致検証" do
        fill_in "ユーザー名",	with: "test_user"
        fill_in "メールアドレス",	with: "test@test.com"
        fill_in "パスワード",	with: "password"
        fill_in "パスワード再確認",	with: "password_confirmation"
        click_button "Signup"

        expect(page).to have_content "再確認用パスワードとパスワードの入力が一致しません"
      end
    end
  end

  # describe "show ユーザーワークスペース" do
  #   let(:user) { FactoryBot.create(:user) }
  #   before do
  #     visit user_path(user.id)
  #   end
  #   context "表示確認" do
      
  #   end
    
  # end
end
