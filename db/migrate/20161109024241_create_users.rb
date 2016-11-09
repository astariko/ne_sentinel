class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :make
      t.string :username
      t.string :password
      t.string :state
      t.string :privilege

      t.timestamps null: false
    end
  end
end
