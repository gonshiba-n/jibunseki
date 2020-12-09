require 'rails_helper'

RSpec.describe Target, type: :model do
  describe "バリデーション" do
    context "valid" do
      it "バリデーションが有効であること"
    end

    context "invalid" do
      it "空白なら無効であること"
      it "target_bodyが255文字を超えたら無効であること"
      it "startがdeadlineよりも時間軸が前であれば無効であること"
    end
  end
end
