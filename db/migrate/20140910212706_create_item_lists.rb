class CreateItemLists < ActiveRecord::Migration
  def change
    create_table :item_lists do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
