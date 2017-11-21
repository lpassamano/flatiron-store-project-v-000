class CreateOrders < ActiveRecord::Migration
  def change
    create_table :order do |t|
      t.integer :cart_id
      t.integer :user_id
    end
  end
end
