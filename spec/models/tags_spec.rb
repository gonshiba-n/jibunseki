require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "バリデーション" do
    context "valid" do
      it "バリデーションが有効であること" do
        expect(FactoryBot.build(:tag)).to be_valid
      end
    end

    context "invalid" do
      it "空白ならばエラー文を返すこと" do
        tag = FactoryBot.build(:tag, question_body: nil, tag: nil)
        tag.valid?
        expect(tag.errors[:question_body]).to include "を入力してください"
        expect(tag.errors[:tag]).to include "を入力してください"
      end

      it "質問が50文字以上なら登録出来ないこと" do
        tag = FactoryBot.build(:tag, question_body: "#{"a" * 51}")
        tag.valid?
        expect(tag.errors[:question_body]).to include "は50文字以内で入力してください"
      end

      it "タグの名前がが10文字以上なら登録出来ないこと" do
        tag = FactoryBot.build(:tag, tag: "#{"a" * 11}")
        tag.valid?
        expect(tag.errors[:tag]).to include "は10文字以内で入力してください"
      end

      it "ベースタグはwill,can,mustでひとつずつ以上tureを保持しないこと"

      it "Will,Can,Mustで6件ずつ以上は登録できないこと"

      it "wcmにwill,can,must以外のデータであればエラーを返すこと" do
        tag = FactoryBot.build(:tag, :none)
        tag.valid?
        expect(tag.errors[:wcm]).to include "不正な値を検出しました"
      end
    end
  end
end
