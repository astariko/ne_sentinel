class AddLoadselectionToUser < ActiveRecord::Migration
  def change
    add_column :users, :loadselection, :text
  end
end
