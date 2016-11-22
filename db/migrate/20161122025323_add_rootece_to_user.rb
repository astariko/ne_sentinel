class AddRooteceToUser < ActiveRecord::Migration
  def change
    add_column :users, :rootece, :text
  end
end
