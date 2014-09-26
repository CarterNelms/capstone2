class RemoveRentTermsFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :min_duration, :integer
    remove_column :items, :max_duration, :string
    remove_column :items, :rate, :decimal
  end
end
