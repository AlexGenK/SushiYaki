function add_to_cart(id) {

	id='prod_'+id;
	var x=localStorage.getItem(id);
	x=+x+1;
	localStorage.setItem(id, x);
	alert("You add sushi with ID #"+id+ " - "+x);

}

function how_items_to_cart() {

	var sum=0;

	for ( var i = 0; i < localStorage.length; ++i ) {
  		sum = sum+localStorage.getItem(localStorage.key( i ))*1;
	}
	alert(sum+" element on card")

}