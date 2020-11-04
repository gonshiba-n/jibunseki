require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "バリデーション" do
    let(:user) { FactoryBot.create(:user) }

    context "valid" do
      it "バリデーションが有効であること" do
        expect(FactoryBot.build(:tag)).to be_valid
      end
    end

    context "invalid" do
      it "空白ならばエラー文を返すこと" do
        tag = FactoryBot.build(:tag, question_body: nil, tag: nil)
        expect(tag).not_to be_valid
      end

      it "質問が50文字以上なら登録出来ないこと"

      it "タグの名前がが10文字以上なら登録出来ないこと"

      it "ベースタグはwill,can,mustでひとつずつ以上tureを保持しないこと"

      it "wcmにwill,can,must以外のデータが入らないこと"
    end
  end
end
