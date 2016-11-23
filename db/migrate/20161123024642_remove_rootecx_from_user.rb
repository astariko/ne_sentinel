class RemoveRootecxFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :rootecx, :text
  end
end
