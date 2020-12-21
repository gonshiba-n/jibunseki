Company.seed(:id) do |s|
  s.id = 1
  s.name = "じぶんセキ株式会社"
  s.url = "https://jibunseki.herokuapp.com"
  s.business = "Webアプリケーション 自己分析フレームワークを提供している"
  s.business_fit = 5
  s.culture = "アットホームな社風であり、チームワークを活かして様々な挑戦を行ってく"
  s.culture_fit = 5
  s.future = "将来の日本に貢献し、次の世代の日本をより良くしていくことが最終目標である"
  s.future_fit = 5
  s.skill = "Ruby on Railsを用いた開発を主に行い、必要に応じて適切な技術をキャッチアップしていくことが可能"
  s.skill_fit = 5
  s.treatment = "福利厚生や、給与は平均的である。"
  s.treatment_fit = 5
  s.user_id = User.find_by(id: 1).id
end