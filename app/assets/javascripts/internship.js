$(function(){
	$('.applyinternbtn').on('click',function(e){
		$('#internship_id').val($(this).data('iid'))

		$('#internshiplabel').html('Application for '+$(this).data('ititle'))
		console.log($(this).data('iid'),$(this).data('ititle'))
	});

	$('#resume').fileupload({
		dataType: 'json',
		// formData: {id: $('#internship_id').val(),message : $('#message').val().trim()},
		add: function(e,data){
			console.log(e,data)
			data.context = $('#apply')
				.click(function(){
					d = {};
					data.formData = {id:$('#internship_id').val(),message: $('#message').val().trim()};
					d.id = $('#internship_id').val();
					d.message = $('#message').val().trim();
					$('#apply').html('Uploading');
					console.log('Uploading')
					data.submit();
				})
		},
		progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        console.log(progress);
        if(progress==100){
        	$('#apply').html('Uploaded');
        	$('#apply').attr('disabled',true);
        	}
    	},done: function(e,data){
			console.log('fe');
			$('#apply').html('Uploaded');
			$('#apply').attr('disabled',true);
		}
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
	});
	$(document).on('click','#discard',function(){
		console.log('fewf')
		$('#sendmessage').modal('hide');
		$('#send_message_btn').html('Send Message');
		$('#discard').attr('id','send_message_btn');
		
	})
})