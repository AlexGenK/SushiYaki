// продукт с номером id добавляется в корзину
function add_to_cart(id) {

	// формируем ключ для веб хранилища
	id='prod_'+id;
	
	// получам информацию (сколько уже продуктов с данным id находится в корзине) 
	// из веб хранилища по ключу
	var x=localStorage.getItem(id);
	x=+x+1;
	
	// записываем информацию в веб хранилище
	localStorage.setItem(id, x);

	// передаем строку с продуктами в корзине в форму
	set_orders();
	// отображаем на кнопке количество заказов
	show_how_many_items();

}

// сколько продуктов находится в корзине
function how_many_items_in_cart() {

	var sum=0;

	// проходим по всей длинне хранилища
	for (var i = 0; i < localStorage.length; ++i) {

		// получаем ключ из хранилища
		var key = localStorage.key(i);

		// суммируем только те значения, ключи которых начинаются с prod_
		if (key.indexOf('prod_')==0) {
  			sum = sum+localStorage.getItem(key)*1;
		}
	}

	return sum;

}

// удаление продуктов из корзины
function remove_items_from_cart() {

	// проходим по всей длинне хранилища
	var len = localStorage.length
	for (var i = 0; i < len; ++i) {

		// получаем ключ из хранилища
		var key = localStorage.key(i);

		// удаляем только те значения, ключи которых начинаются с prod_
		if (key.indexOf('prod_')==0) {
  			localStorage.removeItem(key);
  			// при этом уменьшаем на единицу порядковый номер ключа и размер хранилища
  			i-=1;
  			len-=1;
		}

	}

	// передаем строку с продуктами в корзине в форму
	set_orders();
	// отображаем на кнопке количество заказов
	show_how_many_items();

}


// продукты в корзине возвращаются в виде строки 'ключ=количество' с разделителями - запятыми
function items_in_cart() {

	var str_item='';

	// проходим по всей длинне хранилища
	for (var i = 0; i < localStorage.length; ++i) {

		// получаем ключ из хранилища
		var key = localStorage.key(i);

		// суммируем только те значения, ключи которых начинаются с prod_
		if (key.indexOf('prod_')==0) {
  			str_item = str_item+key+'='+localStorage.getItem(key)+',';
		}
	}

	return str_item;

}


// функция, передающая строку с продуктами в корзине в поле ввода для дальнейшей обработки
function set_orders() {
	$('#orders').val(items_in_cart());
}

// функция, передающая строку с указанием количества заказов в надпись на кнопке корзины
function show_how_many_items() {
	$('#orders_but').text(' Корзина ('+how_many_items_in_cart()+')');
}