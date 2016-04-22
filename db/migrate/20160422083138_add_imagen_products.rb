class AddImagenProducts < ActiveRecord::Migration
  def change
    add_column :products, :image, :string
    change_column :products, :status, :boolean
  end
end
