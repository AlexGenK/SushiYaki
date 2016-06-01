class CreateOrders < ActiveRecord::Migration
  def change

  		create_table :orders do |t|
  			t.string :name
  			t.string :phone
  			t.string :addres
  			t.text :comment
  			t.string :products
  			
  			t.timestamps
  		end
  end
end
