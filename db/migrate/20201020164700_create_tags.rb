class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.text :question_body
      t.text :tag
      t.string :wcm, null: false
      t.boolean :base_tag, default: false, null: false
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
