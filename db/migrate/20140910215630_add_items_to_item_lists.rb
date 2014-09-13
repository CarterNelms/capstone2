class AddItemsToItemLists < ActiveRecord::Migration
  def change
    add_column :item_lists, :item_ids, :integer
  end
end
