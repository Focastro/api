class AddIdUsersTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :user_prod_req, :integer
    add_column :transactions, :user_prod_offe, :integer
  end
end
