require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    it "サインアップ画面のリクエストが成功すること" do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST/users/create" do
    context "正常なPOSTリクエストの場合" do
      it "リクエストが成功すること" do
          post users_path, params: {user: FactoryBot.attributes_for(:user)}
          expect(response.status).to eq 302
      end

      it "ユーザーが登録されること" do
        expect {
          post users_path, params: {user: FactoryBot.attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it "リダイレクトすること" do
        post users_path, params: {user: FactoryBot.attributes_for(:user)}
        expect(response).to redirect_to user_path(User.last)
      end
    end

    context "異常なPOSTリクエストの場合" do
      it "リクエストが成功すること" do
          post users_path, params: {user: FactoryBot.attributes_for(:user, :invalid)}
          expect(response.status).to eq 200
      end

      it "ユーザーが登録されないこと" do
        expect {
          post users_path, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        }.not_to change{User}
      end

      it "エラーが表示されること" do
        post users_path, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        expect(response.body).to include 'パスワードは6文字以上で入力してください'
      end
    end
  end
end
