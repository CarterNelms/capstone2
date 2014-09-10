class AddItemsToItemLists < ActiveRecord::Migration
  def change
    add_column :item_lists, :items, :has_many
  end
end
