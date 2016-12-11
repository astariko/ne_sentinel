class AddBranchNameToNes < ActiveRecord::Migration
  def change
    add_column :nes, :branch_name, :text
  end
end
