module TestHelper
  def login_for_app(user)
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "Login"
  end
end
