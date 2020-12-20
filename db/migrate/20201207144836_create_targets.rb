class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.string :target_body, null: false
      t.datetime :start, nill: false
      t.datetime :deadline, null: false
      t.boolean :achieve, default: false
      t.integer :period, nill:false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
