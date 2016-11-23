class RemoveRootecFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :rootec, :text
  end
end
