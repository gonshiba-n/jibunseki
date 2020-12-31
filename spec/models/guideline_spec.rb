require 'rails_helper'

RSpec.describe Guideline, type: :model do
  describe "バリデーション" do
    it "バリデーションが有効であること" do
      expect(FactoryBot.build(:guideline)).to be_valid
    end

    it "textが空だと無効であること" do
      guideline = FactoryBot.build(:guideline, text: nil)
      guideline.valid?
      expect(guideline.errors[:text]).to include("を入力してください")
    end

    it "user_idが空だと無効であること" do
      guideline = FactoryBot.build(:guideline, user_id: nil)
      guideline.valid?
      expect(guideline.errors[:user_id]).to include("を入力してください")
    end
  end
end
