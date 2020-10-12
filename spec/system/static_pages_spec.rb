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
		end
	end
end