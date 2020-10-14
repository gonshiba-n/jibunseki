require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:other_user) {FactoryBot.create(:user)}

  context "バリデーション" do
    it "バリデーションが有効である" do
      expect(user).to be_valid
    end

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

    it "メールアドレスが空白なら無効" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "メールアドレスが重複したら無効" do
      other_user = FactoryBot.build(:user, email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include("はすでに存在します")
    end

    it "メールアドレスに'@'と'@'の後に'.'が含まれていなければ無効" do
      user = FactoryBot.build(:user, email: "email_address")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "パスワードが空白なら無効" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードは6文字以上であること" do
      user = FactoryBot.build(:user, :invalid)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "パスワードと確認用パスワードが一致しなければ無効" do
      user = FactoryBot.build(:user, password: "password", password_confirmation: "password_confirmation")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end
end
