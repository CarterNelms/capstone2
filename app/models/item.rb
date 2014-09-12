class Item < ActiveRecord::Base
  belongs_to :item_list

  def proper_class_name
    self.class.proper_class_name
  end

  def self.type_names
    self.descendants.map{|d| d.proper_class_name}
  end

  def self.proper_class_name
    self.name.gsub(/(?=[A-Z])/, ' ').strip!
  end
end