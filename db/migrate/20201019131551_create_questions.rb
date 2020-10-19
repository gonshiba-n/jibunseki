class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :wcm, null: false
      t.text :question_body
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
