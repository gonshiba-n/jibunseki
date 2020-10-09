class User < ApplicationRecord
    has_secure_password validations: true

    # バリデーション
    validates :name, presence: true, length: { maximum: 30 }
    # メールアドレスの形か判定するための変数
    email_check = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: { with: email_check }

end
