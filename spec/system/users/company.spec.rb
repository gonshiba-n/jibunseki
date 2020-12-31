require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
let!(:user) { FactoryBot.create(:user) }
let!(:company) { FactoryBot.create(:company, user: user) }

context "表示確認" do
  
end

context "有効なCRUD処理" do
  
end

context "無効なCRUD処理" do
  
end

end

# def click_create_modal
#   find("#achieve1").click
# end

# def click_edit_modal
#   find("#achieve1").click
# end
