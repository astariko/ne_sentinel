class CreateNes < ActiveRecord::Migration
  def change
    create_table :nes do |t|
      t.string :name
      t.string :ip
      t.string :version

      t.timestamps null: false
    end
  end
end
