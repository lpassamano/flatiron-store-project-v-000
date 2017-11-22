class StoreController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
    #raise params.inspect
  end
end
