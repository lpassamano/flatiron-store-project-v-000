class CartsController < ApplicationController
  def show
    if current_cart
      @cart = current_cart
    else
      @cart = Cart.find(params[:id])
    end
  end

  def checkout
    current_cart.update_items_inventory
    current_cart.update(status: "submitted")
    @cart = Cart.find(current_cart.id)

    current_user.current_cart = nil
    current_user.save

    redirect_to cart_path(@cart), { notice: "Your order has successfully been submitted."}
  end
end
