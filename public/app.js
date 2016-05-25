function bubu() {
	var x=localStorage.getItem('xxx');
	x=+x+1;
	localStorage.setItem('xxx', x);
	alert(x);
}

function add_to_cart(id) {
	alert("You add sushi with ID #"+id);
}