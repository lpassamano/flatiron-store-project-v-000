class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items

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

  def add_item(item_id)
    if line = self.line_items.where(item_id: item_id).first
      line
    else
      self.line_items.build(item_id: item_id)
    end
  end
end
