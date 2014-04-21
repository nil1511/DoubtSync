$(function(){
	$('#updateprofileform').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        live: 'enabled', 
        submitButtons : '#updateprofile',
        fields: {
            first_name: {
                message: 'The last name is not valid',
                validators: {
                    notEmpty: {
                        message: 'The first name is required and cannot be empty'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: 'The first name must be more than 6 and less than 30 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z_]+$/,
                        message: 'The first name can only consist of alphabetical'
                    }
                }
            },
            last_name: {
                message: 'The last name is not valid',
                validators: {
                    notEmpty: {
                        message: 'The last name is required and cannot be empty'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: 'The last name must be more than 6 and less than 30 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z_]+$/,
                        message: 'The last name can only consist of alphabetical'
                    }
                }
            },
            'mobile[phone]': {
                message: 'The mobile number is not valid',
                validators: {
                    stringLength: {
                        min: 9,
                        max: 12,
                        message: 'The mobile must be more than 9 and less than 12 characters long'
                    },
                    regexp: {
                        regexp: /^[0-9]+$/,
                        message: 'The last name can only consist of numbers'
                    }
                }
            },
            'user[dob]': {
                message: 'This date of birth is not valid',
                validators: {
                	notEmpty: {
                        message: 'The date of birth is required and cannot be empty'
                    },
                    date: {
                        format: 'YYYY-MM-DD',
                        message: 'The date must be of form MM/DD/YYYY'
                    },
                    callback: {
                        message: 'Invalid Date must be aleast 17 year old',
                        callback: function(value, validator) {
                            var m = new Date(value);
                           	year = (Date.now() - m)/31557600000;
                            if (year > 17) {
                                return true;
                            }
                            return false;
                        }
                    }
                }
            },
            'degree': {
                message: 'This degree is not valid',
                validators: {
                	notEmpty: {
                        message: 'The degree is required and cannot be empty'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z.() ,]+$/,
                        message: 'The degree consist of alphabetical only'
                    }
                }
            },
            graduate: {
                validators: {
                    notEmpty: {
                        message: 'The graduate is required and cannot be empty'
                    },
                    stringLength: {
                        min: 4,
                        max: 4,
                        message: 'The year must be of length 4'
                    },
                    regexp: {
                    	regexp: /^[0-9]+$/,
                        message: 'This input is not a vaild year'
                    },
                    callback: {
                        message: 'Invalid graduation year',
                        callback: function(value, validator) {
                        	if (value > 2000 && value < 2020) {
                                return true;
                            }else
                            	return false;
                          
                        }
                    }
                }
            }
        }
    });



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

$('#send_message_btn').on('click',function(){
	if($('#message').val().trim()!==''){
		data = {};
		data.text = $('#message').val();
		$.post('/message/'+$('#send_message').data('userid'),{message: JSON.stringify(data)},function(res){
			if(res==$('#send_message').data('userid')){
				$('#message').val('');
				$('#send_message_btn').html('Sent');
				$('#send_message_btn').attr('id','discard');
			}
		})
	}
})
$(document).on('click','#discard',function(){
	$('#sendmessage').modal('hide');
	$('#send_message_btn').html('Send Message');
	$('#discard').attr('id','send_message_btn');
	
})

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

