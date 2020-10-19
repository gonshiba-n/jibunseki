class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :wcm, null: false
      t.text :answer_body
      t.boolean :base_tag, default: false, null: false
      t.references :user, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.timestamps
    end
  end
end
