require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  describe "ユーザーログインページ" do
    let(:user) { FactoryBot.create(:user) }

    context "表示確認" do
      it "Loginの文字列が表示されていること" do
        visit login_path
        expect(page).to have_content 'Login'
      end
    end

    context "ユーザーログイン機能" do
      it "正常なユーザーログイン処理" do
        login_for_app(user)

        @user = User.find_by(name: user.name)
        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_selector '.alert', text: "#{@user.name}さん！ログインしました。"
      end

      it "異常なユーザーログイン処理" do
        visit login_path
        fill_in "メールアドレス", with: " "
        fill_in "パスワード", with: " "
        click_button "Login"

        expect(page).to have_content 'メールアドレスとパスワードの組み合わせが誤っています'
      end
    end
  end
end
