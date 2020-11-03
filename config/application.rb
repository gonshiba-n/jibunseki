require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jibunseki
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # CSS, JavaScriptファイルは生成しない
    config.generators do |g|
      g.assets false
      g.test_framework false
      #ジェネレート時にRSpecのテストファイルも作成
      g.test_framework :rspec,
      #テストデータベースにレコードを作成するファイルの作成をスキップ
      fixtures: false,
      #ビュースペックを作成しないことを指定
      view_specs: false,
      #ヘルパーファイル用のスペックを作成しないことを指定
      helper_specs: false,
      #ルーディング用のスペックファイルの作成を省略
      routing_specs: false
    end

    #日本時間設定
    config.time_zone = 'Asia/Tokyo'
    #日本語設定
    config.i18n.default_locale = :ja
    #起動時にja.ymlを読み込みさせる
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
