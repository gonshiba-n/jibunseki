# じぶんセキ
<br>URL: https://www.jibunseki.com

## アプリケーション概要 ※現在制作中
自己分析サポートアプリです。<br>
自身の様々な考えからWill,Can,Mustに沿ったアウトプットを行い思考を整理、 <br>
その中から重要な思考を文章として行動指標へ落とし込みます。<br>
この行動指標をベースに、目標設定や企業研究を行ってもらい<br>
自己分析から目標管理まで一貫してサポート可能なように作成しました。<br>
またシングルページアプリケーションとして,画面遷移のストレスを軽減し<br>
よりユーザーが自己分析に集中できるようなアプリケーション作成を心がけて制作しています。

##使用技術<br>
使用言語/FW<br>
HTML / CSS(SCSS) / JavaScript / Ruby / Ruby on Rails

DB<br>
PostgreSQL

インフラ<br>
AWS: VPC / EC2 / Route53<br>
Webサーバー Nginx<br>
Appサーバー Unicorn<br>

デプロイ<br>
Capistrano

バージョン管理<br>
Git / GitHub

## アプリケーション機能
・AjaxによるCRUD処理<br>
・Ajaxによる画面遷移<br>
・ログイン機能<br>
・ソート(ransack)<br>
・検索(ransack)<br>

## 実装予定
・自己分析サポート質問機能<br>
・通知機能<br>
・目標のシェア機能<br>
・メール機能<br>


## 作成動機
私はエンジニアとなり、日本の労働生産性低下に貢献したいと考えています。<br>
その最初の入り口として、作ろうと考えたのがじぶんセキです。<br>
自身が本当にやりたいことを見つけるために、<br>
自己分析から行動指針を決め、達成したい目標に向かって前進していくことをサポートすることで、<br>
その人が持つポテンシャルを最大限引き出し、生産性をあげたいと思い作成しました。<br>
このアプリケーションはエンジニアになった後でも継続して制作を続けたいと考えています。

##各機能におけるアプリケーション作成への思い
###1.タグ
Will,Can,Mustの自己分析結果をタグとして落とし込む際、10文字以内という制約をかけています。<br>
これは自己分析の妨げとなる余分なワードを極力排除してシンプルにすることで、陥りがちな思考の複雑化による混乱を避けたいと考えたからです。<br>
さらに同様の理由でWill,Can,Mustのタグ作成には各6個までの制約をかけています。<br>
その中で、ユーザーが特に重視しているタグをWill,Can,Must各１個ずつ、ベースタグとして作成します。<br>
核となるタグを選択し、絞ってもらうことで、より純度の高いユーザーのWill,Can,Mustの単語を視覚化したいと考えました。

###2.行動指標
行動指標は、ベースタグから構成されます。<br>
ベースタグの断片的な単語をしっかりと文章として落とし込むことで、自身の行動の軸をしっかりと確認することが可能です。<br>
行動指標に沿って、様々な選択を行うことで常に自身の思考を再確認でき、自己実現への道を遠回りするリスクを軽減します。<br>
また、自己実現にはブレが生じます。<br>
その際に、一つの道標としても活用できると考えています。<br>

###3.目標設定
行動指標から、そこに至るまでの道筋を長期、中期、短期目標として設定してもらいます。<br>
目標を短期から長期と着々とこなしていくことで、自己実現のステップアップをサポートします。<br>
道のりと、結果を目標設定から視覚化し、積み上げてきた実績と目標達成の成功体験を実感してもらうことで<br>
モチベーションの維持、向上を狙っています。<br>
また目標達成への期間もあえて設定しています。<br>
これは目標と現実のギャップを認識してもらうことで、何をなくてはいけないのかを確認してもらいたいと考えたからです。

###4.企業分析
自己実現のために企業を選ぶというのはとても重要な要素だと認識しています。<br>
その為、なぜその企業なのかをじぶんセキに落とし込み、志望度とマッチング度を数値化することで、企業分析をサポートします。<br>
項目ごとに、数値化した結果がなぜなのかを、記録できるようにも作成しています。<br>

この4つの要素からじぶんセキは成り立っています。
是非一度、上のURLからご覧頂ければ幸いです。
