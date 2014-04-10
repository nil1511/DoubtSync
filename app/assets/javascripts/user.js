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
	var uid = $(this).parent('li').parent('ul').data('uid');
	$.get('/users/'+uid+'/following',function (data){
		var ele ='';
		for(e in data){
			ele += '  <li class="media" style="background-color:#FFFFFF">\
  <a class="pull-left" href="/users/'+data[e].username+'">\
    <img class="media-object" src="'+data[e].photo+'" alt=" " style="width:80px; height:80px;">\
  </a>\
  <div class="media-body">\
    <h4 class="media-heading">'+data[e].name+'</h4>\
	<h5 class="media-heading">'+data[e].college+'</h5>\
  </div>';
		}
		var div = '<h4>Following</h4><div class="well" style="width:400px"><ul class="media-list">'+ele+'</ul></div>';
		$('#displayarea').html(div);
	});
});

$('#follower').on('click',function (e){
	var uid = $(this).parent('li').parent('ul').data('uid');
	$.get('/users/'+uid+'/followers',function (data){
			var ele ='';
		for(e in data){
		ele += '  <li class="media" style="background-color:#FFFFFF">\
  <a class="pull-left" href="/users/'+data[e].username+'">\
    <img class="media-object" src="'+data[e].photo+'" alt=" " style="width:80px; height:80px;">\
  </a>\
  <div class="media-body">\
    <h4 class="media-heading">'+data[e].name+'</h4>\
	<h5 class="media-heading">'+data[e].college+'</h5>\
  </div>';
		}
		var div = '<h4>Follower</h4><div class="well" style="width:400px"><ul class="media-list">'+ele+'</ul></div>';
		$('#displayarea').html(div);
	});
});

$('#myquestion').on('click',function (e){
	var uid = $(this).parent('li').parent('ul').data('uid');
	$.get('/posts/'+uid+'/index',function (data){
			var ele ='';
		for(e in data){
			var img ='';
			var p = '<div class="singlepost well" data-pid="' + data[e].id + '">\
            <div class="media"><div class="media-body">\
            <h4 class="media-heading" style="color:#00557D">me</h4><p>' + data[e].text + '</p></div></div></div>';
			ele += p;
		}
		var div = '<div>'+ele+'</div>';
		$('#displayarea').html(div);
	});
});

$('#myanswer').on('click',function (e){
	var uid = $(this).parent('li').parent('ul').data('uid');
	$.get('/comments/'+uid+'/index',function (data){
			var ele ='';
		for(e in data){
			var img ='';
			var p = '<div class="singlepost well" data-pid="' + data[e].id + '">\
            <div class="media"><div class="media-body">\
            <h4 class="media-heading" style="color:#00557D">me</h4><p>' + data[e].text + '</p></div></div></div>';
			ele += p;
		}
		var div = '<div>'+ele+'</div>';
		$('#displayarea').html(div);
	});
});

});

