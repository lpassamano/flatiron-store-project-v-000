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
end
