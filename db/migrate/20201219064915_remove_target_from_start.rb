class RemoveTargetFromStart < ActiveRecord::Migration[5.2]
  def change
    remove_column :targets, :start, :date
  end
end
