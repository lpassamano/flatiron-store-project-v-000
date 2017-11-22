class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    total = 0
    line_items.each do |line|
      quantity = line.quantity
      price = line.item.price
      subtotal = price * quantity
      total += subtotal
    end
    total
  end

  def display_total
    self.total.to_f/100
  end

  def add_item(item_id)
    line = self.line_items.where(item_id: item_id).first
    if line.present?
      line.quantity = line.quantity + 1
      line
    else
      self.line_items.build(item_id: item_id)
    end
  end

  def update_items_inventory
    self.line_items.each do |line|
      line.item.inventory = line.item.inventory - line.quantity
      line.item.save
    end
  end
end
