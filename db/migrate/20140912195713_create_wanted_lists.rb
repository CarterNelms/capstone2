class CreateWantedLists < ActiveRecord::Migration
  def change
    create_table :wanted_lists do |t|

      t.timestamps
    end
  end
end
