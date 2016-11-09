class RemoveFieldNameFromTableName < ActiveRecord::Migration
  def change
    remove_column :users, :make, :string
  end
end
