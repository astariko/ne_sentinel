class AddBranchToNes < ActiveRecord::Migration
  def change
    add_reference :nes, :branch, index: true, foreign_key: true
  end
end
