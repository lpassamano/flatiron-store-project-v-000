class CartsController < ApplicationController
  def show
    #raise "in show controller"
    if current_cart
      #raise "finding cart!"
      @cart = current_cart
    else
      @cart = Cart.find(params[:id])
    end
  end

#<Cart id: 21, status: nil, user_id: 9>
  def checkout
    #raise "in checkout"
    current_cart.line_items.each do |line|
      line.item.inventory = line.item.inventory - line.quantity
      line.item.save
    end
    #raise "updated inventory on all items"

    @cart = Cart.find(current_cart.id)
    @cart.status = "submitted"
    @cart.save
    #raise "@cart should be submitted, cart_id 21"

    current_user.current_cart = nil
    current_user.save
    #raise "current_user.current_cart shoudl be nil"
    redirect_to cart_path(@cart), { notice: "Your order has successfully been submitted."}
  end
end

##["Practical Linen Clock: 2, current inventory 54", "Aerodynamic Granite Bag: 1, current inventory 45", "Small Aluminum Coat: 1, current inventory 82", "Heavy Duty Bronze Watch: 1, current inventory 22", "Durable Marble Chair: 1, current inventory 61"]]
