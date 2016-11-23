class RemoveRooteceFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :rootece, :text
  end
end
