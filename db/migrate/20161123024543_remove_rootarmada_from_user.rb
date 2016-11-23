class RemoveRootarmadaFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :rootarmada, :text
  end
end
