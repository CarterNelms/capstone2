class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :item_list, index: true

      t.timestamps
    end
  end
end
