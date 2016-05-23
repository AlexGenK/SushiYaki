class AddProducts < ActiveRecord::Migration

  def change
  	Product.create 	:title => 'Калифорния',
  					:description => 'Роллы с авокадо, снежным крабом и икрой летучей рыбы.',
  					:path_to_pict => '/Image/California.jpg',
  					:quantity => 6,
  					:weight =>  170,
  					:best_offer => false,
  					:price => 8500

  	Product.create 	:title => 'Филадельфия',
  					:description => 'Роллы с кунжутом, тобико, фетой, лососем и огурцом.',
  					:path_to_pict => '/Image/Filadelfia.jpg',
  					:quantity => 6,
  					:weight =>  180,
  					:best_offer => true,
  					:price => 6500

  	Product.create 	:title => 'Каппа маки',
  					:description => 'Роллы с огурцом.',
  					:path_to_pict => '/Image/CappaMaki.jpg',
  					:quantity => 6,
  					:weight =>  160,
  					:best_offer => false,
  					:price => 3000

  	Product.create 	:title => 'Кани спайси',
  					:description => 'Острые роллы со снежным крабом.',
  					:path_to_pict => '/Image/CappaMaki.jpg',
  					:quantity => 6,
  					:weight =>  160,
  					:best_offer => false,
  					:price => 4000
  end

end
