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
  					:path_to_pict => '/Image/KaniSpicy.jpg',
  					:quantity => 6,
  					:weight =>  160,
  					:best_offer => false,
  					:price => 5000

    Product.create  :title => 'Маруяки сякэ',
            :description => 'Роллы из обжареного лосося с соусом тартар в икре капеллана.',
            :path_to_pict => '/Image/Maruyaki.jpg',
            :quantity => 7,
            :weight =>  210,
            :best_offer => true,
            :price => 6000

    Product.create  :title => 'Салмон',
            :description => 'Роллы с лососем, огурцом и авокадо.',
            :path_to_pict => '/Image/Salmon.jpg',
            :quantity => 8,
            :weight =>  220,
            :best_offer => false,
            :price => 6800

    Product.create  :title => 'Спайси сякэ',
            :description => 'Острые роллы с лососем и сыром.',
            :path_to_pict => '/Image/SpicySyake.jpg',
            :quantity => 6,
            :weight =>  170,
            :best_offer => false,
            :price => 6900

    Product.create  :title => 'Нинуку киноко',
            :description => 'Роллы из грибов с нежным чесночным кремом.',
            :path_to_pict => '/Image/Niniku.jpg',
            :quantity => 6,
            :weight =>  160,
            :best_offer => false,
            :price => 5900

  end

end
