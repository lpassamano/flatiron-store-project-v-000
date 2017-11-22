class LineItemsController < ApplicationController
  def create
    unless !!current_cart
      current_user.current_cart = current_user.carts.create
    end

    line_item = current_user.current_cart.add_item(params[:item_id])
    if line_item.save
      item = Item.find(line_item[:item_id])
      current_user.save
      redirect_to cart_path(current_cart), {notice: "#{item.title.capitalize} added to cart!"}
    else
      redirect_to store_path, { notice: "There was an error adding item to cart."}
    end
  end
end
