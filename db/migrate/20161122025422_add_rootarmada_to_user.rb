class AddRootarmadaToUser < ActiveRecord::Migration
  def change
    add_column :users, :rootarmada, :text
  end
end
