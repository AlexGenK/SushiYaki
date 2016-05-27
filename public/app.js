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
	alert("You add sushi with ID #"+id+ " - "+x);

}

// сколько продуктов находится в корзине
function how_items_to_cart() {

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

// продукты в корзине возвращаются в виде строки 'ключ=количество'
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

	console.log(str_item);
	return str_item;

}