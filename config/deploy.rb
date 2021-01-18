# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.15.0'

# Capistranoのログの表示に利用する
set :application, 'jibunseki'
set :deploy_to, '/var/www/jibunseki'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:gonshiba-n/jibunseki.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.7.2'
set :nvm_type, :user
set :nvm_node, 'v14.8.0'
set :yarn_target_path, -> { release_path.join('client') } #
set :yarn_flags, '--production --silent --no-progress'    # default
set :yarn_roles, :all                                     # default
set :yarn_env_variables, {}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system node_modules client/node_modules}

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/jibunseki_user/id_rsa']

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end