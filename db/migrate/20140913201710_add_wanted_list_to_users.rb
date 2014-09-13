class AddWantedListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wanted_list_id, :integer
  end
end
