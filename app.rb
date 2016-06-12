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

# Модель - пользователь магазина
class User < ActiveRecord::Base

	# правила верификации
	validates :login, :password, presence: true
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

# админская область - запрос пароля
get '/admin' do
	erb :admin
end

# вывод содержимого корзины
post '/cart' do
	# получаем массив с информацией о продуктах в заказе
	$hh=orders_to_hash(params[:orders])

	@o=Order.new
	erb :cart
end

# обработка оформленного заказа
post '/order' do

	# формируем строку с названиями продуктов и их количеством (массив с этими значениями мы уже получили ранее)
	prodstring=''
	$hh[:order_items].each {|item| prodstring+="#{item[:product].title} - #{item[:quantity]} шт., "}

	# получаем в виде хэша значения из формы заказа
	orderhash = params[:ord]

	# и добавляем к нему сформированную строку с товарами и сумму заказа
	orderhash['products']=prodstring[0..-3]
	orderhash['sum']=$hh[:order_sum]

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

# ввод админского пароля
post '/admin' do

	userhash=params[:usr]
	@orders=Order.order(:created_at)

	# получаем первую записть из модели User
	user_admin = User.first

	# если ее не существует, то записывем введенное в качестве админского логина/пароля
	if user_admin==nil

		# верифицируем введенные данные
		user_admin=User.new userhash
		if user_admin.save
			erb :orderslist
		else
			@error=user_admin.errors.full_messages.first
			erb :admin
		end

	# если существует - сверяем введенное с имеющимся админским логином/паролем
	else
		if (user_admin.login==userhash['login'])&&(user_admin.password==userhash['password'])
			erb :orderslist
		else
			@error='Логин или пароль не верны. Попробуйте еще.'
			erb :admin
		end
	end

end

# удаление всех записей из таблицы заказов
post '/del_orders' do
	Order.delete_all
	erb '<h1 style="color: red">Список заказов очищен</h1>'
end

# преобразуем строку с парами ключ=количество в формате localStorage в хэш, содержащий
# массив с данными о продуктах и сумму заказа
def orders_to_hash(str)

	# разбиваем строку с парами ключ=количество в формате localStorage на отдельные пары
	pairs=str.split(",")

	aa=[]
	hh={}
	sum=0

	pairs.each do |item| 

		# из каждой пары извлекаем ключ продукта и его количество
		key = item.split("=")[0].delete!('prod_').to_i
		value = item.split("=")[1].to_i
		myprod=Product.find(key)
		# формируем элемент массива с объектом-продуктом из заказа и его количеством
		aa<<{:product=>myprod, :quantity=>value}
		# формируем сумму заказа
		sum+=value*myprod.price/100

	end

	hh[:order_items]=aa
	hh[:order_sum]=sum
	return hh
end