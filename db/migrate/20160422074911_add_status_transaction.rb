class AddStatusTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :status , :boolean
  end
end
