class AddParametersToItems < ActiveRecord::Migration
  def change
    add_column :items, :name, :string
    add_column :items, :min_duration, :integer
    add_column :items, :max_duration, :string
    add_column :items, :rate, :decimal
  end
end
