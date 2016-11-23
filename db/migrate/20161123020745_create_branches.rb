class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.boolean :completed
      t.string :root
      t.string :http
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
