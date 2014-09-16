class Item < ActiveRecord::Base
  belongs_to :item_list

  def proper_class_name
    self.class.proper_class_name
  end

  def self.type_names
    self.descendants.map{|d| d.proper_class_name}
  end

  def self.type_symbols
    self.descendants.map{|d| d.class_symbol}
  end

  def self.type_symbols_plural
    self.descendants.map{|d| d.class_symbol.to_s.pluralize.to_sym}
  end

  def self.proper_class_name
    self.name.gsub(/(?=[A-Z])/, ' ').strip!
  end

  def self.class_symbol
    self.name.gsub(/(?=[A-Z])/, ' ').strip!.gsub(/\s/, '_').downcase.to_sym
  end
end