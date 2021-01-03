require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "バリデーション" do
    context "valid" do
      it "バリデーションが有効であること" do
        expect(FactoryBot.build(:company)).to be_valid
      end
    end

    context "invalid" do
      it "空白ならばエラー文を返すこと" do
        company = FactoryBot.build(:company, name: nil, url: nil)
        company.valid?
        expect(company.errors[:name]).to include "を入力してください"
        expect(company.errors[:url]).to include "を入力してください"
      end

      it "nameが30文字を超えたらエラーとなること" do
        company = FactoryBot.build(:company, name: "#{'a' * 31}")
        company.valid?
        expect(company.errors[:name]).to include "は30文字以内で入力してください"
      end

      it "URLはhttp(https):から始まらないと無効な状態であること" do
        company = FactoryBot.build(:company, url: "aa")
        company.valid?
        expect(company.errors[:url]).to include('は不正な値です')
      end

      it "800文字を超えたらエラーとなること" do
        company = FactoryBot.build(:company, business: "#{"a" * 801}")
        company.valid?
        expect(company.errors[:business]).to include "は800文字以内で入力してください"
      end

      it "数字意外ならエラーとなること" do
        company = FactoryBot.build(:company, business_fit: "a")
        company.valid?
        expect(company.errors[:business_fit]).to include "は数値で入力してください"
      end

      it "数値の1~5以外であればエラーになること" do
        company_business = FactoryBot.build(:company, business_fit: 0)
        company_culture = FactoryBot.build(:company, culture_fit: 6)
        company_business.valid?
        company_culture.valid?
        expect(company_business.errors[:business_fit]).to include "は0より大きい値にしてください"
        expect(company_culture.errors[:culture_fit]).to include "は6より小さい値にしてください"
      end
    end

    context "method" do
      it "aspirationメソッドの合計値が算出すること" do
        company = FactoryBot.build(:company,
                                   business_fit: 5,
                                   culture_fit: 5,
                                   vision_fit: 5,
                                   future_fit: 5,
                                   skill_fit: 5,
                                   treatment_fit: 5,)
        expect(company.aspiration).to eq(30)
      end
    end
  end
end
