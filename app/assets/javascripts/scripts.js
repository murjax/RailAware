$(document).ready( function () {
	console.log('hello');
	$('#railroad').change(function(){
		if(this.options[this.selectedIndex].value == "Other"){
			$('#loco1otherrailroad').show();
		}
		else{
			$('#loco1otherrailroad').hide();
		}
	});
	
	$('#railroad2').change(function(){
		if(this.options[this.selectedIndex].value == "Other"){
			$('#loco2otherrailroad').show();
		}
		else{
			$('#loco2otherrailroad').hide();
		}
	});
	
	$('#railroad3').change(function(){
		if(this.options[this.selectedIndex].value == "Other"){
			$('#loco3otherrailroad').show();
		}
		else{
			$('#loco3otherrailroad').hide();
		}
	});
	
	$('#railroad4').change(function(){
		if(this.options[this.selectedIndex].value == "Other"){
			$('#loco4otherrailroad').show();
		}
		else{
			$('#loco4otherrailroad').hide();
		}
	});
	
	$('#railroad5').change(function(){
		if(this.options[this.selectedIndex].value == "Other"){
			$('#loco5otherrailroad').show();
		}
		else{
			$('#loco5otherrailroad').hide();
		}
	});
	
	$('#railroad6').change(function(){
		if(this.options[this.selectedIndex].value == "Other"){
			$('#loco6otherrailroad').show();
		}
		else{
			$('#loco6otherrailroad').hide();
		}
	});
	
	$(document).on('click', '.vbutton', function(evt){
		console.log($(evt.target).parent());
		var vote;
		if($(evt.target).parent().is('div#up')){
			vote = 1;
			console.log("true");
		}else{
			vote = -1;
			console.log("false");
		}
		
		var id = $(evt.target).parent().parent().children(":first").html();
		var data = [id, vote];
		console.log(id);
		console.log(data[0])
		$.ajax({
			data: JSON.stringify({'data' : data}),
			dataType: 'json',
			type: 'post',
			url: "/main/vote",
			contentType: 'application/json',
			cache: false
		});
		$(evt.target).parent().parent().children('.vbutton').hide()
		evt.preventDefault();
	});
	$('#table_id').DataTable();
});

var a = 0;
var b = 0;
var c = 0;
var d = 0;
var e = 0;
function addLoco2(){
	if (a == 0){
		document.getElementById('loco2num').style.display = "block";
		document.getElementById('loco2type').style.display = "block";
		document.getElementById('loco2railroad').style.display = "block";
		document.getElementById('loco3check').style.display = "block";
		a = 1;
	}else{
		document.getElementById('loco2num').style.display = "none";
		document.getElementById('loco2type').style.display = "none";
		document.getElementById('loco2railroad').style.display = "none";
		document.getElementById('loco3check').style.display = "none";
		a = 0;
	}
	
}

function addLoco3(){
	if (b == 0){
		document.getElementById('loco3num').style.display = "block";
		document.getElementById('loco3type').style.display = "block";
		document.getElementById('loco3railroad').style.display = "block";
		document.getElementById('loco4check').style.display = "block";
		b = 1;
	}else{
		document.getElementById('loco3num').style.display = "none";
		document.getElementById('loco3type').style.display = "none";
		document.getElementById('loco3railroad').style.display = "none";
		document.getElementById('loco4check').style.display = "none";
		b = 0;
	}
}

function addLoco4(){
	if (c == 0){
		document.getElementById('loco4num').style.display = "block";
		document.getElementById('loco4type').style.display = "block";
		document.getElementById('loco4railroad').style.display = "block";
		document.getElementById('loco5check').style.display = "block";
		c = 1;
	}else{
		document.getElementById('loco4num').style.display = "none";
		document.getElementById('loco4type').style.display = "none";
		document.getElementById('loco4railroad').style.display = "none";
		document.getElementById('loco5check').style.display = "none";
		c = 0;
	}
}

function addLoco5(){
	if (d == 0){
		document.getElementById('loco5num').style.display = "block";
		document.getElementById('loco5type').style.display = "block";
		document.getElementById('loco5railroad').style.display = "block";
		document.getElementById('loco6check').style.display = "block";
		d = 1;
	}else{
		document.getElementById('loco5num').style.display = "none";
		document.getElementById('loco5type').style.display = "none";
		document.getElementById('loco5railroad').style.display = "none";
		document.getElementById('loco6check').style.display = "none";
		d = 0;
	}
}

function addLoco6(){
	if (e == 0){
		document.getElementById('loco6num').style.display = "block";
		document.getElementById('loco6type').style.display = "block";
		document.getElementById('loco6railroad').style.display = "block";
		e = 1;
	}else{
		document.getElementById('loco6num').style.display = "none";
		document.getElementById('loco6type').style.display = "none";
		document.getElementById('loco6railroad').style.display = "none";
		e = 0;
	}
}
