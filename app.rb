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

get '/order' do
	redirect '/'
end

# вывод содержимого корзины
post '/cart' do
	# получаем массив с информацией о продуктах в заказе
	$aa=orders_to_array(params[:orders])

	# вычисляем сумму заказа
	$prodsum=0
	$aa.each {|item| $prodsum+=item[:quantity]*item[:product].price/100}

	@o=Order.new
	erb :cart
end

# обработка оформленного заказа
post '/order' do

	# формируем строку с названиями продуктов и их количеством (массив с этими значениями мы уже получили ранее)
	prodstring=''
	$aa.each {|item| prodstring+="#{item[:product].title} - #{item[:quantity]} шт., "}

	# получаем в виде хэша значения из формы заказа
	orderhash = params[:ord]

	# и добавляем к нему сформированную строку с товарами и суммой
	orderhash['products']="#{prodstring[0..-3]} на общую сумму #{"%6.2f" % $prodsum} грн."

	# создаем новый заказ
	@o=Order.new orderhash

	# если успешно - возвращемся на главную страницу,
	# если нет - выводим сообщение об ошибках и опять возвращаемся к форме оформления заказа
	if @o.save
		erb :order
	else
		@error=@o.errors.full_messages.first
		erb :cart
	end

end

# преобразуем строку с парами ключ=количество в формате localStorage в массив хэшей. 
# каждый элемент массива - строчка заказа - хэш с порядковым номером, объектом-продуктом
# и количеством продукта
def orders_to_array(str)

	# разбиваем строку с парами ключ=количество в формате localStorage на отдельные пары
	pairs=str.split(",")
	aa=[]
	i=0

	pairs.each do |item| 

		# из каждой пары извлекаем ключ продукта и его количество
		key = item.split("=")[0].delete!('prod_').to_i
		value = item.split("=")[1].to_i

		# формируем элемент массива с объектом-продуктом из заказа и его количеством
		aa[i]={:n=>i+1, :product=>Product.find(key), :quantity=>value}
		i+=1
	end
	return aa
end