require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:user) {FactoryBot.create(:user)}

  describe "GET /sessions" do
    context "正常なPOSTリクエストの場合" do
      it "ログイン画面のリクエストが成功すること" do
        get login_path
        expect(response).to have_http_status(200)
      end

      it "ログインに成功すること" do
        post login_path, params: {user: FactoryBot.attributes_for(:user)}
        expect(response).to redirect_to user_path(user.id)
      end
    end

    context "異常なPOSTリクエストの場合" do
      it "エラーが表示されること" do
        post users_path, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        expect(response.body).to include 'パスワードは6文字以上で入力してください'
      end
    end
  end

  describe "DELETE/sessions" do
    it "ログアウト" do
      delete logout_path
      expect(response).to redirect_to root_path
    end
  end
end
