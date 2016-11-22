class AddRootpss4ToUser < ActiveRecord::Migration
  def change
    add_column :users, :rootpss4, :text
  end
end
