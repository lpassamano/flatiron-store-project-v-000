class LineItemsController < ApplicationController
  def create
    unless !!current_cart
      current_user.create_current_cart
      current_cart.user = current_user
    end
    line_item = current_user.current_cart.add_item(params[:item_id])
    if line_item.save
      item = Item.find(line_item[:item_id])
      redirect_to cart_path(current_cart), {notice: "#{item.title.capitalize} added to cart!"}
    else
      redirect_to store_path
    end
  end
end
