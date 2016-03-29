class AddColumnIdUserProducts < ActiveRecord::Migration
  def change
    add_column :products, :id_user , :integer
  end
en