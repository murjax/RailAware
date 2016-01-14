$.fn.dataTableExt.afnFiltering.push(
	function(oSettings, aData, iDataIndex){
		
		var dateStart = parseDateValue($("#beginDate").val());
		var dateEnd = parseDateValue($("#endDate").val());
		var evalDate = parseDateValue(cutTimeFromDate(aData[8]));
		
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

$(document).ready( function () {
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
		responsive: true
	});
	
	$('#beginDate').keyup( function() {$table.draw();} );
	$('#endDate').keyup( function() {$table.draw();} );
	$('#beginDate').change( function() {$table.draw();} );
	$('#endDate').change( function() {$table.draw();} );
	
});

