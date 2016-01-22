$.fn.dataTableExt.afnFiltering.push(
	function(oSettings, aData, iDataIndex){
		
		var dateStart = parseDateValue($("#beginDate").val());
		var dateEnd = parseDateValue($("#endDate").val());
		var evalDate = parseDateValue(cutTimeFromDate(aData[5]));
		
		if (evalDate >= dateStart && evalDate <= dateEnd){
			return true;
		}
		else{
			return false;
		}
		
		

	});
	
function cutTimeFromDate(rawDatetime){
	return rawDatetime.substr(0, 10)
}
function parseDateValue(rawDate){
	var dateArray = rawDate.split("/");
	var parsedDate = dateArray[2] + dateArray[0] + dateArray[1];
	return parsedDate;
}

function format(l, t, r, a, i){
	/*return '<div>Locomotive Number: ' + l + '</div>' + 
		'<div>Locomotive Type: ' + t + '</div>' + 
		'<div>Locomotive Railroad: ' + r + '</div>' + 
		'<div>Additional: ' + a + '</div>' + 
		'<div>Extra Info: ' + i + '</div>';*/
		
	return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
		'<tr>' +
			'<td class="lightweighttext">Locomotive Number:</td>' +
			'<td>' + l + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Locomotive Type:</td>' +
			'<td>' + t + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Locomotive Railroad:</td>' +
			'<td>' + r + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Additional:</td>' +
			'<td>' + a + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Extra Info:</td>' +
			'<td>' + i + '</td>' +
		'</tr>' +
		'</table>';
}

function mobileFormat(l, t, r, d, dt, a, i){
	return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
		'<tr>' +
			'<td class="lightweighttext">Locomotive Number:</td>' +
			'<td>' + l + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Locomotive Type:</td>' +
			'<td>' + t + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Locomotive Railroad:</td>' +
			'<td>' + r + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Direction:</td>' +
			'<td>' + d + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Date/Time:</td>' +
			'<td>' + dt + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Additional:</td>' +
			'<td>' + a + '</td>' +
		'</tr>' +
		
		'<tr>' +
			'<td class="lightweighttext">Extra Info:</td>' +
			'<td>' + i + '</td>' +
		'</tr>' +
		'</table>';
}

$(document).ready( function () {
	var mobile = false;
	if($(document).width() <  700){
		$('.mobilehide').hide();
		var mobile = true;
	}
	$(document).on('click', '.vbutton', function(evt){
		var vote;
		if($(evt.target).parent().is('div#up')){
			vote = 1;
		}else{
			vote = -1;
		}
		
		var id = $(evt.target).parent().parent().children(":first").html();
		var data = [id, vote];
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

	$('.datepicker').datepicker();
	$('#endDate').datepicker('setDate', new Date());
	var $table = $('#table_id').DataTable({
		//responsive: true
	});
	
	$('#table_id').on('click', 'td.details-control', function(){
		
		var tr = $(this).closest('tr');
		var row = $table.row(tr);
		var loconumber = tr.find('#loconumber').html();
		var locotype = tr.find('#locotype').html();
		var railroad = tr.find('#railroad').html();
		var additional = tr.find('#additional').html();
		var direction = tr.find('#direction').html();
		var time = tr.find('#time').html();
		var info = tr.find('#info').text()
		if (row.child.isShown()){
			row.child.hide();
			tr.removeClass('shown');
		}else{
			if (mobile){
				row.child(mobileFormat(loconumber, locotype, railroad, direction, time, additional, info)).show();
			}else{
				row.child(format(loconumber, locotype, railroad, additional, info)).show();
			}
			
			tr.addClass('shown');
		}
	});
	
	$('#beginDate').keyup( function() {$table.draw();} );
	$('#endDate').keyup( function() {$table.draw();} );
	$('#beginDate').change( function() {$table.draw();} );
	$('#endDate').change( function() {$table.draw();} );
	
});

