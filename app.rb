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

# процедура инициализации
configure do

end

# главная страница
get '/' do
	# выбираем все продукты в алфавитном порядке
	@prod=Product.order(:title)
	erb :index
end

# 1
get '/about' do
	erb :about
end

# 2
get '/two' do
	erb "<h2> Two </h2>"
end

# 3
get '/three' do
	erb "<h2> Three </h2>"
end

# форма оформления заказа
get '/order' do
	@o=Order.new
	erb :order
end

# вывод содержимого корзины
post '/cart' do
	# получаем хэш с парами ключ продукта=количество заказов
	$hh=orders_to_hash(params[:orders])
	i=0
	@aa=[]
	# из хэша формируем массив хэшей, где каждый хэш - строка в выводимой таблице 
	# (наименование, цена, количество, суммарная цена)
	$hh.each do |key, value| 
		product=Product.find(key)
		@aa[i]={:name=>product.title, :price=>(product.price/100).to_f, :quantity=>value, :sumprice=>(value*product.price/100).to_f}
		i+=1
	end
	erb :cart
end

# обработка оформленного заказа
post '/order' do

	# формируем строку с товарами и их количеством (хэш с этими значениями мы уже получили ранее)
	# а также общую сумму заказа
	prodstring=''
	prodsum=0

	$hh.each do |key, value| 
		product=Product.find(key)
		prodstring+="#{product.title} - #{value} шт. "
		prodsum+=value*product.price/100
	end

	# получаем в виде хэша значения из формы заказа
	orderhash = params[:ord]

	# и добавляем к нему сформированную строку с товарами и суммой
	orderhash['products']="#{prodstring}на сумму #{prodsum} грн."

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

# возвращает сообщение о возможных ошибках. принмимает хеш с парой
# имя_параметра=>выводимое сообщение. если параметр пустой, формируется сообщение
def get_error_message(hh)
	err=""
	hh.each_key {|param| err+=hh[param] if params[param].strip==""}
	return err
end

# преобразуем строку с парами ключ=количество в формате localStorage в аналогичный хэш, 
# с парами ключ=количество но в формате модели Product
def orders_to_hash(str)
	aa=str.split(",")
	hh={}
	aa.each {|item| hh[item.split("=")[0].delete!('prod_').to_i]=item.split("=")[1].to_i}
	return hh
end