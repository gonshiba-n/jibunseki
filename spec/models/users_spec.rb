require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    context "valid" do
      it "バリデーションが有効であること" do
        expect(FactoryBot.build(:user)).to be_valid
      end
    end

    context "invalid" do
      it "名前が空白なら無効であること" do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "名前の長さが30文字以上であること" do
        user = FactoryBot.build(:user, name: "a" * 31)
        user.valid?
        expect(user.errors[:name]).to include("は30文字以内で入力してください")
      end

      it "メールアドレスが空白なら無効であること" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "メールアドレスが重複したら無効あること" do
        other_user = FactoryBot.create(:user)
        user = FactoryBot.build(:user, email: other_user.email)
        user.valid?
        expect(user.errors[:email]).to include("はすでに存在します")
      end

      it "メールアドレスに'@'と'@'の後に'.'が含まれていなければ無効であること" do
        user = FactoryBot.build(:user, email: "email_address")
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end

      it "パスワードが空白なら無効であること" do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "パスワードは6文字以上であること" do
        user = FactoryBot.build(:user, :invalid)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it "パスワードと確認用パスワードが一致しなければ無効であること" do
        user = FactoryBot.build(:user, password: "password",
                                       password_confirmation: "password_confirmation")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end
end
