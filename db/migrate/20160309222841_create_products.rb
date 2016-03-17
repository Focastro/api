class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :status
      t.integer :id_user

      t.timestamps null: false
    end
  end
end