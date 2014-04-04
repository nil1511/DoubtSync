$(function(){

$('#updateprofile').on('click',function (e) {
	var button = true;
	if($('#first_name').val().trim()==""){
		$('#first_name').parent().parent('.form-group').addClass('has-error');
		button = false;
	}
	else
		$('#first_name').parent().parent('.form-group').removeClass('has-error');
	

	if($('#last_name').val().trim()==""){
		$('#last_name').parent().parent('.form-group').addClass('has-error');
		button = false;
	}
	else
		$('#last_name').parent().parent('.form-group').removeClass('has-error');
	

	if(typeof($('#degree').val())!=='undefined' && $('#degree').val().trim()==""){
		$('#degree').parent().parent('.form-group').addClass('has-error');
		button = false;
	}
	else if(typeof($('#degree').val())!=='undefined')
		$('#degree').parent().parent('.form-group').removeClass('has-error');
	
	
	if(typeof($('#graduate').val())!=='undefined' && $('#graduate').val().trim()==""){
		$('#graduate').parent().parent('.form-group').addClass('has-error');
		button = false;
	}
	else if(typeof($('#graduate').val())!=='undefined')
		$('#graduate').parent().parent('.form-group').removeClass('has-error');

	return button;

});


$('#following').on('click',function (e){
	$.get('/users/'+$(this).data('uid')+'/following',function (data){
		var ele ='';
		for(e in data){
			ele += '<li><a href="/users/'+data[e].username+'"><div>\
    <img class="followpic" src="'+data[e].photo+'"><label>'+data[e].name+'</label></div></a></li>'
		}
		var div = '<ul class="followlist">'+ele+'</ul>';
		$('#displayarea').html(div);
	});
});

$('#follower').on('click',function (e){
	$.get('/users/'+$(this).data('uid')+'/followers',function (data){
			var ele ='';
		for(e in data){
			ele += '<li><a href="/users/'+data[e].username+'"><div>\
    <img class="followpic" src="'+data[e].photo+'"><label>'+data[e].name+'</label></div></a></li>'
		}
		var div = '<ul class="followlist">'+ele+'</ul>';
		$('#displayarea').html(div);
	});
});


});

