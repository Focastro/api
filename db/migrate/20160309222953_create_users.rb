class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :firstname

      t.timestamps null: false
    end
  end
end

#class CambiarNombre < ActiveRecord::Migration
  #def change
    #rename_column :users, :password, :password_digest
  #end
#end