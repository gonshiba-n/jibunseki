require 'rails_helper'

RSpec.describe Target, type: :model do
  describe "バリデーション" do
    context "valid" do
      it "バリデーションが有効であること" do
        expect(FactoryBot.build(:target)).to be_valid
      end
    end

    context "invalid" do
      it "空白なら無効であること" do
        target = FactoryBot.build(:target,
                                  target_body: nil,
                                  start: nil,
                                  deadline: nil,
                                  achieve: nil,
                                  period: nil,
                                )
        target.valid?
        expect(target.errors[:target_body]).to include "を入力してください"
        expect(target.errors[:start]).to include "を入力してください"
        expect(target.errors[:deadline]).to include "を入力してください"
      end

      it "target_bodyが50文字を超えたら無効であること" do
        target = FactoryBot.build(:target, target_body: "#{"a" * 51}")
        target.valid?
        expect(target.errors[:target_body]).to include "は50文字以内で入力してください"
      end

      it "startがdeadlineよりも時間軸が前であれば無効であること" do
        target = FactoryBot.build(:target,
                                  start: "2020-12-30 00:00:00",
                                  deadline: "2020-12-01 00:00:00",
                                )
        target.valid?
        expect(target.errors[:start]).to include "は、目標達成予定日時よりも前に設定してください。"
      end
    end
  end
end
