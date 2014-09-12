class ItemList < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def add(item)
    old_item_count = self.items.length
    self.items << item if item.class.ancestors.include?(Item) && item.class != Item
    self.save!
    self.items.length > old_item_count
  end
end
