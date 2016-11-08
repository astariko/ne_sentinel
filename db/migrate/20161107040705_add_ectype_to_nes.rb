class AddEctypeToNes < ActiveRecord::Migration
  def change
    add_column :nes, :ectype, :text
  end
end
