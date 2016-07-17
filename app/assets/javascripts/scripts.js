
var menucheck = 0
	

$(document).ready( function () {
	
	$('nav ul').addClass('js').before('<div id="menu">&#9776;</div>');
	$('#menu').click(function(){
		$('nav ul').toggle();
		if(menucheck == 0){
			$('.header').height(300);
			$('.content').css({top: '300px'});
			$('.homecontent').css({top: '300px'});
			menucheck = 1;
		}else{
			$('.header').height(60);
			$('.content').css({top: '60px'});
			$('.homecontent').css({top: '60px'});
			menucheck = 0;
		}
		
	});
	if(window.innerWidth > 800) {
			$("#menu").hide();
	}
	$(window).resize(function(){
		if(window.innerWidth > 800) {
			$("#menu").hide();
		}else{
			$("#menu").show();
		}
	});
	
	// Set default report time to the user's current time.
	var currenttime = new Date();
	var monthList = new Array();
	monthList[0] = "January";
	monthList[1] = "February";
	monthList[2] = "March";
	monthList[3] = "April";
	monthList[4] = "May";
	monthList[5] = "June";
	monthList[6] = "July";
	monthList[7] = "August";
	monthList[8] = "September";
	monthList[9] = "October";
	monthList[10] = "November";
	monthList[11] = "December";
	var month = currenttime.getMonth();
	var date = currenttime.getDate();
	var year = currenttime.getFullYear();
	var hour = currenttime.getHours();
	var minute = currenttime.getMinutes();
	if(minute < 10){
		var firstTenString = "0" + minute;
		$('#report_time_5i').val(firstTenString);
	}else{
		$('#report_time_5i').val(minute);
	}
	$('#report_time_2i').val(month + 1);
	$('#report_time_3i').val(date);
	$('#report_time_1i').val(year);
	$('#report_time_4i').val(hour);
	
	/*$('#locomotive_remove_link').click(function(){
		$(this).closest(".pure-control-group").prev().children("input[type=hidden]").value = 1
		$(this).closest(".locomotive_fields").hide()
		
	})*

});


function addLoco2(){
	if (a == 0){
		document.getElementById('loco2num').style.display = "block";
		document.getElementById('loco2type').style.display = "block";
		document.getElementById('loco2railroad').style.display = "block";
		document.getElementById('loco2direction').style.display = "block";
		document.getElementById('loco3check').style.display = "block";
		a = 1;
	}else{
		document.getElementById('loco2num').style.display = "none";
		document.getElementById('loco2type').style.display = "none";
		document.getElementById('loco2railroad').style.display = "none";
		document.getElementById('loco2direction').style.display = "none";
		document.getElementById('loco3check').style.display = "none";
		a = 0;
	}
	
}

function addLoco3(){
	if (b == 0){
		document.getElementById('loco3num').style.display = "block";
		document.getElementById('loco3type').style.display = "block";
		document.getElementById('loco3railroad').style.display = "block";
		document.getElementById('loco3direction').style.display = "block";
		document.getElementById('loco4check').style.display = "block";
		b = 1;
	}else{
		document.getElementById('loco3num').style.display = "none";
		document.getElementById('loco3type').style.display = "none";
		document.getElementById('loco3railroad').style.display = "none";
		document.getElementById('loco3direction').style.display = "none";
		document.getElementById('loco4check').style.display = "none";
		b = 0;
	}
}

function addLoco4(){
	if (c == 0){
		document.getElementById('loco4num').style.display = "block";
		document.getElementById('loco4type').style.display = "block";
		document.getElementById('loco4railroad').style.display = "block";
		document.getElementById('loco4direction').style.display = "block";
		document.getElementById('loco5check').style.display = "block";
		c = 1;
	}else{
		document.getElementById('loco4num').style.display = "none";
		document.getElementById('loco4type').style.display = "none";
		document.getElementById('loco4railroad').style.display = "none";
		document.getElementById('loco4direction').style.display = "none";
		document.getElementById('loco5check').style.display = "none";
		c = 0;
	}
}

function addLoco5(){
	if (d == 0){
		document.getElementById('loco5num').style.display = "block";
		document.getElementById('loco5type').style.display = "block";
		document.getElementById('loco5railroad').style.display = "block";
		document.getElementById('loco5direction').style.display = "block";
		document.getElementById('loco6check').style.display = "block";
		d = 1;
	}else{
		document.getElementById('loco5num').style.display = "none";
		document.getElementById('loco5type').style.display = "none";
		document.getElementById('loco5railroad').style.display = "none";
		document.getElementById('loco5direction').style.display = "none";
		document.getElementById('loco6check').style.display = "none";
		d = 0;
	}
}

function addLoco6(){
	if (e == 0){
		document.getElementById('loco6num').style.display = "block";
		document.getElementById('loco6type').style.display = "block";
		document.getElementById('loco6railroad').style.display = "block";
		document.getElementById('loco6direction').style.display = "block";
		e = 1;
	}else{
		document.getElementById('loco6num').style.display = "none";
		document.getElementById('loco6type').style.display = "none";
		document.getElementById('loco6railroad').style.display = "none";
		document.getElementById('loco6direction').style.display = "none";
		e = 0;
	}
}

function displayLocationFields(){
	if (f == 0){
		document.getElementById('citybox').style.display = "block";
		document.getElementById('statebox').style.display = "block";
		document.getElementById('locationpicker').style.display = "none";
		f = 1;
	}else {
		document.getElementById('citybox').style.display = "none";
		document.getElementById('statebox').style.display = "none";
		document.getElementById('locationpicker').style.display = "block";
		f = 0;
	}
}