module QuestionAssistancesHelper
    def any_of_wcm
    [
      "will",
      "will",
      "will",
      "can",
      "can",
      "can",
      "must",
      "must",
      "must",
    ]
  end

  def questions
    {
      "理想の将来像を入力しましょう" => "あなたは将来、なりたいものはありますか？",
      "人生の中で一番重要視しているものを入力しましょう" => "スキル、お金、時間何を重視しますか？(この他でも解答可)",
      "その人のどういうところを目標としたいのか理由を入力しましょう" => "あなたには目標にしている人物はいますか？",
      "あなたの最も自身のあるスキルを入力しましょう" => "あなたの得意なことは何ですか？",
      "あなたの最も成果を出した経験から、自身のあるスキルを入力しましょう" => "あなたの得意なことは何ですか？",
      "長所を入力しましょう！" => "あなたの長所は何ですか？",
      "自身の課題を入力しましょう" => "あなたがクリアするべきミッションを一つ上げてみましょう",
      "人から求められるスキルを確認しましょう" => "あなたが他の人から、最も求められているものは何ですか？",
      "キャリアの方向性を定めましょう！" => "あなたは今後、どんなキャリアを積むべきですか？",
    }
  end

  def questions_count
    questions.length
  end
end
