function bubu() {
	var x=localStorage.getItem('xxx');
	x=+x+1;
	localStorage.setItem('xxx', x);
	alert(x);
}