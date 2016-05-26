function bubu() {
	var x=localStorage.getItem('xxx');
	x=+x+1;
	localStorage.setItem('xxx', x);
	alert(x);
}

function add_to_cart(id) {
	id='prod_'+id
	var x=localStorage.getItem(id);
	x=+x+1;
	localStorage.setItem(id, x);
	alert("You add sushi with ID #"+id+ " - "+x);
}