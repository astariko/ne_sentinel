class AddUserToNes < ActiveRecord::Migration
  def change
    add_reference :nes, :user, index: true, foreign_key: true
  end
end
