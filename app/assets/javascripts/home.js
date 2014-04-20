$(function(){
	// $('#college_id').select2();
	$('#college_id').select2({
    	placeholder: "Select a College",
    	allowClear: true
	});
	$('#loginform .btn.login').on('click',function (event) {

		if($('#user_username').val()==''){
			$('#user_username').parent('.form-group').addClass('has-error')
			return false;
		}
		if($('#user_password').val()==''){
			$('#user_password').parent('.form-group').addClass('has-error')
			return false;
		}
	})
});