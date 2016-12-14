class AddLatestLoadToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :latest_load, :text
  end
end
