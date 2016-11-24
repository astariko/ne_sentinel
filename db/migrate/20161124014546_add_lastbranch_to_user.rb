class AddLastbranchToUser < ActiveRecord::Migration
  def change
    add_reference :users, :lastbranch, index: true, foreign_key: true
  end
end
