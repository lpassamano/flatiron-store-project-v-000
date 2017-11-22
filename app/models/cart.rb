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

  def add_item(item_id)
    line = self.line_items.where(item_id: item_id).first
    if line.present?
      line.quantity = line.quantity + 1
      line.save 
      self.save
    else
      self.line_items.create(item_id: item_id)
    end
  end
end
