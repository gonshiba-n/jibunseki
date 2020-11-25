class CreateGuidelines < ActiveRecord::Migration[5.2]
  def change
    create_table :guidelines do |t|
      t.text :guideline
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
