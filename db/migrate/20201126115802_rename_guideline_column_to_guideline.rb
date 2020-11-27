class RenameGuidelineColumnToGuideline < ActiveRecord::Migration[5.2]
  def change
    rename_column :guidelines, :guideline, :text
  end
end
