class AddActiveTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :active, :boolean
  end
end
