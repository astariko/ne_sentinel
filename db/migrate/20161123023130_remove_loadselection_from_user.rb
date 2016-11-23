class RemoveLoadselectionFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :loadselection, :text
  end
end
