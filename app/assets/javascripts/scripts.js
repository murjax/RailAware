var a = 0;
var b = 0;
var c = 0;
var d = 0;
var e = 0;
function addLoco2(){
	if (a == 0){
		document.getElementById('loco2num').style.display = "block";
		document.getElementById('loco2type').style.display = "block";
		document.getElementById('loco3check').style.display = "block";
		a = 1;
	}else{
		document.getElementById('loco2num').style.display = "none";
		document.getElementById('loco2type').style.display = "none";
		document.getElementById('loco3check').style.display = "none";
		a = 0;
	}
	
}

function addLoco3(){
	if (b == 0){
		document.getElementById('loco3num').style.display = "block";
		document.getElementById('loco3type').style.display = "block";
		document.getElementById('loco4check').style.display = "block";
		b = 1;
	}else{
		document.getElementById('loco3num').style.display = "none";
		document.getElementById('loco3type').style.display = "none";
		document.getElementById('loco4check').style.display = "none";
		b = 0;
	}
}

function addLoco4(){
	if (c == 0){
		document.getElementById('loco4num').style.display = "block";
		document.getElementById('loco4type').style.display = "block";
		document.getElementById('loco5check').style.display = "block";
		c = 1;
	}else{
		document.getElementById('loco4num').style.display = "none";
		document.getElementById('loco4type').style.display = "none";
		document.getElementById('loco5check').style.display = "none";
		c = 0;
	}
}

function addLoco5(){
	if (d == 0){
		document.getElementById('loco5num').style.display = "block";
		document.getElementById('loco5type').style.display = "block";
		document.getElementById('loco6check').style.display = "block";
		d = 1;
	}else{
		document.getElementById('loco5num').style.display = "none";
		document.getElementById('loco5type').style.display = "none";
		document.getElementById('loco6check').style.display = "none";
		d = 0;
	}
}

function addLoco6(){
	if (e == 0){
		document.getElementById('loco6num').style.display = "block";
		document.getElementById('loco6type').style.display = "block";
		e = 1;
	}else{
		document.getElementById('loco6num').style.display = "none";
		document.getElementById('loco6type').style.display = "none";
		e = 0;
	}
}
