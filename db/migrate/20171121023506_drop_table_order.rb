class DropTableOrder < ActiveRecord::Migration
  def change
    drop_table :order
  end
end
