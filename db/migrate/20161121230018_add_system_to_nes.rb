class AddSystemToNes < ActiveRecord::Migration
  def change
    add_column :nes, :system, :text
  end
end
