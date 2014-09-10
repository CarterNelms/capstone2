class AddTypeToItemLists < ActiveRecord::Migration
  def change
    add_column :item_lists, :type, :string
  end
end
