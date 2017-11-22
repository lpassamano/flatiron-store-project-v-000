class LineItemsController < ApplicationController
  def create
    #raise params.inspect
    unless !!current_cart
      #raise "Creating new cart"
      current_user.current_cart = current_user.carts.create
      #raise "Created new cart"
    end
    #raise "creating line item"
    line_item = current_user.current_cart.add_item(params[:item_id])
    #raise "line item created"
    if line_item.save
      #raise "new line item saved"
      item = Item.find(line_item[:item_id])
      #raise "after declaration of item"
      current_user.save
      #raise "after user.save"
      redirect_to cart_path(current_cart), {notice: "#{item.title.capitalize} added to cart!"}
    else
      #raise "new line item not saved"
      redirect_to store_path
    end
  end
end
