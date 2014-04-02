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
	

	if($('#degree').val().trim()==""){
		$('#degree').parent().parent('.form-group').addClass('has-error');
		button = false;
	}
	else
		$('#degree').parent().parent('.form-group').removeClass('has-error');
	
	
	if($('#graduate').val().trim()==""){
		$('#graduate').parent().parent('.form-group').addClass('has-error');
		button = false;
	}
	else
		$('#graduate').parent().parent('.form-group').removeClass('has-error');
	

	return button;

});

});

