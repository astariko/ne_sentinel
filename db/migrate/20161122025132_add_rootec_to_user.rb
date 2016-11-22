class AddRootecToUser < ActiveRecord::Migration
  def change
    add_column :users, :rootec, :text
  end
end
