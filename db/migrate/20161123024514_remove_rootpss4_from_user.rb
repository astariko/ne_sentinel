class RemoveRootpss4FromUser < ActiveRecord::Migration
  def change
    remove_column :users, :rootpss4, :text
  end
end
