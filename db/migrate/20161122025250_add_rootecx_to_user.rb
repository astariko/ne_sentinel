class AddRootecxToUser < ActiveRecord::Migration
  def change
    add_column :users, :rootecx, :text
  end
end
