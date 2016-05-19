function bubu() {
	var x=localStorage.getItem('x');
	if (x==null) {
		localStorage.setItem('x', 1);
	} else {
		localStorage.setItem('x', x+1);
	}
	x=localStorage.getItem('x');
	alert(x);
}