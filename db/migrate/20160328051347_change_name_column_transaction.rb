class ChangeNameColumnTransaction < ActiveRecord::Migration
  def change
    rename_column :transactions, :product_offered, :product_offered_id
  end
end
