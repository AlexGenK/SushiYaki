class CreateProducts < ActiveRecord::Migration

  def change
  		create_table :products do |t|
  			t.string :title
  			t.text :description
  			t.string :path_to_pict
  			t.decimal :quantity
  			t.decimal :weight
  			t.boolean :best_offer
  			t.decimal :price

  			t.timestamps
  		end
  end

end
