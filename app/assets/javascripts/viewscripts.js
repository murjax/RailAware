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

function format(id, l, i, u, tu){
	
	if(u){
		return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
		'<tr>' +
			'<td class="lightweighttext">Locomotives:</td>' +
			'<td>' + l + '</td>' +
		'<tr>' +
			'<td class="lightweighttext">Extra Info:</td>' +
			'<td>' + i + '</td>' +
		'</tr>' +
		'<tr>' +
			'<td class="lightweighttext">Update Location</td>' +
			'<td><a class="updateicon" href="http://www.railaware.com/editreport?id=' + id + '"></a></td>' +
		'</tr>' +
		'<tr>' +
			'<td class="lightweighttext">Delete Report</td>' +
			'<td><a class="deleteicon" href="http://www.railaware.com/deletereport?id=' + id + '"></a></td>' +
		'</tr>' +
		'</table>';
	}else if(tu){
		return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
		'<tr>' +
			'<td class="lightweighttext">Locomotives:</td>' +
			'<td>' + l + '</td>' +	
		'<tr>' +
			'<td class="lightweighttext">Extra Info:</td>' +
			'<td>' + i + '</td>' +
		'</tr>' +
		'<tr>' +
			'<td class="lightweighttext">Update Location</td>' +
			'<td><a class="updateicon" href="http://www.railaware.com/editreport?id=' + id + '"></a></td>' +
		'</tr>' +
		'</table>';
	}
	else{
		return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
		'<tr>' +
			'<td class="lightweighttext">Locomotives:</td>' +
			'<td>' + l + '</td>' +
		'</tr>' +
		'<tr>' +
			'<td class="lightweighttext">Extra Info:</td>' +
			'<td>' + i + '</td>' +
		'</tr>' +
		'</table>';
	}
	
}

function mobileFormat(id, l, d, dt, i, u, tu){
	
	if(u){
		return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
		'<tr>' +
			'<td class="lightweighttext">Locomotives:</td>' +
			'<td>' + l + '</td>' +
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
			'<td class="lightweighttext">Extra Info:</td>' +
			'<td>' + i + '</td>' +
		'</tr>' +
		'<tr>' +
			'<td class="lightweighttext">Update Location</td>' +
			'<td><a class="updateicon" href="http://www.railaware.com/editreport?id=' + id + '"></a></td>' +
		'</tr>' +
		'<tr>' +
			'<td class="lightweighttext">Delete Report</td>' +
			'<td><a class="deleteicon" href="http://www.railaware.com/deletereport?id=' + id + '"></a></td>' +
		'</tr>' +
		'</table>';
	}else if(tu){
		return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
		'<tr>' +
			'<td class="lightweighttext">Locomotives:</td>' +
			'<td>' + l + '</td>' +
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
			'<td class="lightweighttext">Extra Info:</td>' +
			'<td>' + i + '</td>' +
		'</tr>' +
		'<tr>' +
			'<td class="lightweighttext">Update Location</td>' +
			'<td><a class="updateicon" href="http://www.railaware.com/editreport?id=' + id + '"></a></td>' +
		'</tr>' +
		'</table>';
	}
	else{
		return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
		'<tr>' +
			'<td class="lightweighttext">Locomotives:</td>' +
			'<td>' + l + '</td>' +
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
			'<td class="lightweighttext">Extra Info:</td>' +
			'<td>' + i + '</td>' +
		'</tr>' +
		'</table>';
	}
	
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
		
		var id = $(evt.target).parent().parent().children("#expandableresults").children("#reportid").html();
		var voter = $(evt.target).parent().parent().children("#voterusername").html();
		var data = [id, vote, voter];
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
		var id = tr.find("#reportid").html();
		var locomotives = tr.find(".locomotives").html()
		var direction = tr.find('#direction').html();
		console.log(locomotives)
		var time = tr.find('#time').html();
		var info = tr.find('#info').text()
		if (row.child.isShown()){
			row.child.hide();
			tr.removeClass('shown');
		}else{
			
			var reportOfLoggedInUser;
			if(tr.find('#sameuser').length > 0){
				reportOfLoggedInUser = true;
			}else{
				reportOfLoggedInUser = false;
			}
			
			var trustUser;
			if(tr.find('#trustuser').length > 0){
				trustUser = true;
			}else{
				trustUser = false;
			}
			
			if (mobile){
				row.child(mobileFormat(id, locomotives, direction, time, info, reportOfLoggedInUser, trustUser)).show();
			}else{
				row.child(format(id, locomotives, info, reportOfLoggedInUser, trustUser)).show();
			}
			
			tr.find('.updateicon').on('click', tr.find('.updateicon'), function(evt){
				console.log("link clicked");
			});
			tr.addClass('shown');
		}
	});
	
	$('#beginDate').keyup( function() {$table.draw();} );
	$('#endDate').keyup( function() {$table.draw();} );
	$('#beginDate').change( function() {$table.draw();} );
	$('#endDate').change( function() {$table.draw();} );
	
});

