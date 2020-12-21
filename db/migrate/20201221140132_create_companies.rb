class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :url
      t.text :business
      t.integer :business_fit
      t.text :culture
      t.integer :culture_fit
      t.text :future
      t.integer :future_fit
      t.text :skill
      t.integer :skill_fit
      t.text :treatment
      t.integer :treatment_fit
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
