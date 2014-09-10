class ItemList < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def add(item)
    self.items << item if item.class.ancestors.include? Item
    self.save!
  end
end
