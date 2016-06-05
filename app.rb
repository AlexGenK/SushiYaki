#encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# объявление БД
set :database, "sqlite3:sushiyaki.db"

# Модель - продукт в магазине
class Product < ActiveRecord::Base
	
end

# Модель - заказ
class Order < ActiveRecord::Base

	# правила верификации
	validates :name, :phone, :addres, presence: true
	validates :phone, format: {with: /\A[\d() +-]{5,}\z/, message: "is incorrect."}
	validates :name, :addres, length: {minimum: 2}
end

# главная страница
get '/' do
	# выбираем все продукты в алфавитном порядке
	@prod=Product.order(:title)
	erb :index
end

# о нас
get '/about' do
	erb :about
end

get '/cart' do
	redirect '/'
end

# форма оформления заказа
get '/order' do
	@o=Order.new
	erb :order
end

# вывод содержимого корзины
post '/cart' do
	# получаем хэш с парами ключ продукта=количество заказов
	$aa=orders_to_array(params[:orders])
	erb :cart
end

# обработка оформленного заказа
post '/order' do

	# формируем строку с продуктами и их количеством (массив с этими значениями мы уже получили ранее)
	# а также общую сумму заказа
	prodstring=''
	prodsum=0

	$aa.each do |item| 
		prodstring+="#{item[:name]} - #{item[:quantity]} шт., "
		prodsum+=item[:sumprice]
	end

	# получаем в виде хэша значения из формы заказа
	orderhash = params[:ord]

	# и добавляем к нему сформированную строку с товарами и суммой
	orderhash['products']="#{prodstring[0..-3]} на общую сумму #{"%6.2f" % prodsum} грн."

	# создаем новый заказ
	@o=Order.new orderhash

	# если успешно - возвращемся на главную страницу,
	# если нет - выводим сообщение об ошибках и опять возвращаемся к форме оформления заказа
	if @o.save
		erb :summary
	else
		@error=@o.errors.full_messages.first
		erb :order
	end

end

# преобразуем строку с парами ключ=количество в формате localStorage в массив хэшей. 
# каждый элемент массива - хэш - строчка заказа с детальной информацией о порядковом номере, 
# названии продукта, цене за единицу, количестве, суммарной цене.
def orders_to_array(str)

	# разбиваем строку с парами ключ=количество в формате localStorage на отдельные пары
	pairs=str.split(",")
	aa=[]
	i=0

	pairs.each do |item| 

		# из каждой пары извлекаем ключ продукта и его количество
		key = item.split("=")[0].delete!('prod_').to_i
		value = item.split("=")[1].to_i

		# извлекаем из модели инфомацию о продукте по его ключу
		product=Product.find(key)

		# формируем элемент массива с информацией о продукте в заказе
		aa[i]={:n=>i+1, :name=>product.title, :price=>(product.price/100).to_f, :quantity=>value, :sumprice=>(value*product.price/100).to_f}
		i+=1
	end
	return aa
end