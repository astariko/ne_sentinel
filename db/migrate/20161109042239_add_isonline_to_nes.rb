class AddIsonlineToNes < ActiveRecord::Migration
  def change
    add_column :nes, :isonline, :boolean
  end
end
