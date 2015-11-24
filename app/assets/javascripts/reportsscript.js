$(document).ready( function () {
				$('#table_id').DataTable();
			} );
			
			/*function voteUp(){
				

				$(document).click(function(event){
					
					if($(event.target).hasClass('vbutton')){
						var id = $(event.target).parent().parent().parent().children(":first").html();
						var username = document.getElementById('loggedinuser').innerHTML;
						var vote = 1;
						var xhr;
						if (window.XMLHttpRequest) { // Mozilla, Safari, ...  
							xhr = new XMLHttpRequest();  
						} else if (window.ActiveXObject) { // IE 8 and older  
							xhr = new ActiveXObject("Microsoft.XMLHTTP");  
						}
						var data = "data=" + id + "-" + username + "-" + vote;
						
						xhr.open("POST", "../savevote.php", true);
						xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
						xhr.send(data);
						
						$(event.target).css("display", "none");
						$(event.target).siblings(".vbutton").css("display", "none");
					}
				});
				
			}*/
			
			/*function voteDown(){
				$(document).click(function(event){
					if($(event.target).hasClass('vbutton')){
						var id = $(event.target).parent().parent().parent().children(":first").html();
						var username = document.getElementById('loggedinuser').innerHTML;
						var vote = 0;
						var xhr;
						if (window.XMLHttpRequest) { // Mozilla, Safari, ...  
							xhr = new XMLHttpRequest();  
						} else if (window.ActiveXObject) { // IE 8 and older  
							xhr = new ActiveXObject("Microsoft.XMLHTTP");  
						}
						var data = "data=" + id + "-" + username + "-" + vote;
						
						xhr.open("POST", "../savevote.php", true);
						xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
						xhr.send(data);
						
						$(event.target).css("display", "none");
						$(event.target).siblings(".vbutton").css("display", "none");
					}
				});
			}*/
			var test;
			function vote(){
				$(document).click(function(event){
					if($(event.target).hasClass('vbutton')){
						var id = $(event.target).parent().parent().parent().children(":first").html();
						
						if (test != id){
							test = id;
							
							var username = document.getElementById('loggedinuser').innerHTML;
						
							var vote;
							if($(event.target).has('#up')){
								vote = 1;
							}else{
								vote = 0;
							}
							var xhr;
							if (window.XMLHttpRequest) { // Mozilla, Safari, ...  
								xhr = new XMLHttpRequest();  
							} else if (window.ActiveXObject) { // IE 8 and older  
								xhr = new ActiveXObject("Microsoft.XMLHTTP");  
							}
							var data = "data=" + id + "-" + username + "-" + vote;
							
							xhr.open("POST", "../savevote.php", true);
							xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
							xhr.send(data);
							
							$(event.target).css("display", "none");
							$(event.target).siblings(".vbutton").css("display", "none");
						}
						
					}
					
				});
				
			}