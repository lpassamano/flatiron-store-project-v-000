class CartsController < ApplicationController
  def show
    if current_cart
      @cart = current_cart
    else
      @cart = Cart.find(params[:id])
    end
  end

  def checkout
    current_cart.line_items.each do |line|
      line.item.inventory = line.item.inventory - line.quantity
      line.item.save
    end

    @cart = Cart.find(current_cart.id)
    @cart.status = "submitted"
    @cart.save

    current_user.current_cart = nil
    current_user.save

    redirect_to cart_path(@cart), { notice: "Your order has successfully been submitted."}
  end
end
