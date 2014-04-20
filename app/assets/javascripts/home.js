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
	});
	$('#loginform').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        live: 'enabled', 
        fields: {
            'user[username]': {
                message: 'The username is not valid',
                validators: {
                    notEmpty: {
                        message: 'The username is required and cannot be empty'
                    },
                    stringLength: {
                        min: 6,
                        max: 10,
                        message: 'The username must be more than 6 and less than 10 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z_0-9]+$/,
                        message: 'The first name can only consist of alphabetical and numbers'
                    }
                }
            }
   		}});

	$('#new_user').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        live: 'enabled',
        submitButtons : '#registerbtn',
        fields: {
            'user[username]': {
                message: 'The username is not valid',
                validators: {
                    notEmpty: {
                        message: 'The username is required and cannot be empty'
                    },
                    stringLength: {
                        min: 6,
                        max: 10,
                        message: 'The username must be more than 6 and less than 10 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z_0-9]+$/,
                        message: 'The first name can only consist of alphabetical and numbers'
                    }
                }
            },
            'user[email]': {
                message: 'The email is not valid',
                validators: {
                    notEmpty: {
                        message: 'The email is required and cannot be empty'
                    },
                    emailAddress: {
                        message: 'The email address is not valid'
                    }
                }
            },
            'user[password]': {
                message: 'The password is not valid',
                validators: {
                    notEmpty: {
                        message: 'The password is required and cannot be empty'
                    },stringLength: {
                        min: 8,
                        max: 128,
                        message: 'The password must be more than 8 characters long'
                    }
                }
            },
            'user[password_confirmation]': {
                message: 'The password is not valid',
                validators: {
                    notEmpty: {
                        message: 'The password is required and cannot be empty'
                    },
                    callback: {
                        message: 'Password does not match',
                        callback: function(value, validator) {
                           	if ($('#user_password').val() == value) {
                                return true;
                            }
                            return false;
                        }
                    }
                }
            }
   		}});
});