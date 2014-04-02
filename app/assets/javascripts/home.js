$(function(){
	$('#loginform .btn.login').on('click',function (event) {

		if($('#user_email').val()==''){
			$('#user_email').parent('.form-group').addClass('has-error')
			return false;
		}
		if($('#user_password').val()==''){
			$('#user_password').parent('.form-group').addClass('has-error')
			return false;
		}
	})
});