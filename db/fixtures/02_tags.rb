will = [
          {"あなたは将来、何になりたいですか？" => "将来像の確認"},
          {"あなたは将来、何を実現したいですか？" => "将来像への目的"},
          {"あなたの理想の人は誰ですか？" => "ロールモデルの具現化"},
          {"スキル、お金、時間何を重視しますか？(この他でも解答可)" => "価値観の確認"},
          {"将来、一番欲しいものを手に入れられるとしたら？" => "原動力となる欲求の確認"},
]
can = [
          {"あなたの得意なことは何ですか？" => "現在のスキルの軸の確認"},
          {"あなたの最も成果を出した経験は何ですか？" => "ポテンシャルの把握"},
          {"あなたの長所は何ですか？" => "長所の確認"},
          {"あなたの短所は何ですか？(違う角度から見たらそれは長所と言い換えられます)" => "短所を長所へ変換"},
          {"あなたが生きていく上で捨てられないと思うスキルは？" => "核となるスキルの言語化"},
]
must = [
          {"あなたが第三者から今、最も求められているものは何ですか？" => "社会から求められるスキル"},
          {"あなたがクリアするべきミッションを一つ上げてみましょう" => "自身の課題"},
          {"あなたが将来身に付けるべきスキルは何ですか？" => "将来的なスキルを確認"},
          {"あなたは今後、どんなキャリアを積むべきですか？" => "キャリアの方向性"},
          {"あなたが今解決するべき課題は何ですか？" => "直近のミッション"},
]

will.each do |w|
  Tag.seed(:tag,
    {
      :question_body => w.keys[0],
      :tag => w.values[0],
      :wcm => "will",
      :base_tag => false,
      :user_id => User.find_by(id: 1).id,
    },
  )
end
Tag.seed(:tag) do |s|
  s.tag = "将来像の確認"
  s.base_tag = true
end

can.each do |c|
  Tag.seed(:tag,
    {
      :question_body => c.keys[0],
      :tag => c.values[0],
      :wcm => "can",
      :base_tag => false,
      :user_id => User.find_by(id: 1).id,
    },
  )
end
Tag.seed(:tag) do |s|
  s.tag = "現在のスキルの軸の確認"
  s.base_tag = true
end

must.each do |m|
  Tag.seed(:tag,
    {
      :question_body => m.keys[0],
      :tag => m.values[0],
      :wcm => "must",
      :base_tag => false,
      :user_id => User.find_by(id: 1).id,
    },
  )
end
Tag.seed(:tag) do |s|
  s.tag = "社会から求められるスキル"
  s.base_tag = true
end