module TestHelper
  def login_for_app(user)
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "Login"
  end

  # 企業分析作成の入力(create)
  def company_create_input
    fill_in "企業名:",  with: "株式会社じぶんセキ"
    fill_in "URL:",  with: "https://jibunseki.herokuapp.com"
    fill_in "事業内容:",  with: "Webアプリケーション 自己分析フレームワークを提供している"
    select "3", from: "create-business-fit"
    fill_in "社風/環境:", with: "アットホームな社風であり、チームワークを活かして様々な挑戦を行ってく"
    select "3", from: "create-culture-fit"
    fill_in "ビジョン:",  with: "将来の日本に貢献し、次の世代の日本をより良くしていく"
    select "3", from: "create-culture-fit"
    fill_in "将来性:", with: "少子高齢化で生産性が下がる日本に求められる重要なミッションで拡大していく可能性がある"
    select "3", from: "create-vision-fit"
    fill_in "スキル:", with: "Ruby on Railsを用いた開発を主に行い、必要に応じて適切な技術をキャッチアップしていくことが可能"
    select "3", from: "create-skill-fit"
    fill_in "待遇:", with: "福利厚生や、給与は平均的である。"
    select "3", from: "create-treatment-fit"
    click_button "作成"
  end
end
