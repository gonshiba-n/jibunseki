class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, limit: 30, index: true, null: false
      t.string :email, unique: true, null:false
      t.string :password_digest, null:false
      t.string :remember_token
      t.timestamps
    end
  end
end
