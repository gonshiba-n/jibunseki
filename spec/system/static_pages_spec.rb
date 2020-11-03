require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
	describe "トップページ" do
		context "表示確認" do
			before do
				visit root_path
			end
			it "じぶんセキの文字列が存在すること" do
				expect(page).to have_content 'じぶん'
			end

			it "Logoのリンクが存在すること" do
				expect(page).to have_selector(".header-logo"), href: root_path
			end

			it "ヘッダーのsignupリンクが表示されていること" do
				expect(page).to have_selector(".header-signup"), href: new_user_path
			end

			it "catch-copyセクションのsignupリンクが表示されていること" do
				expect(page).to have_link "なりたいじぶんを見つける", href: new_user_path
			end

			it "ヘッダーのloginリンクが表示されていること" do
				expect(page).to have_link "Login", href: login_path
			end

			it "startセクションのsignupリンクが表示されていること" do
				expect(page).to have_selector(".section-signup"), href: new_user_path
			end
		end
	end
end