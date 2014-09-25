class AddImagesToItems < ActiveRecord::Migration
  def change
    add_column :items, :images, :string
  end
end
