function FormatResult(user) {
markup = "<div class='users' data-userid='"+user.id+"'>"+user.name+"</div>";
return markup;
}

function FormatSelection(user) {
return user.name;
}

$(function(){

    $('#userselect').select2({
            placeholder: "Enter the name of receipent",
            minimumInputLength: 3,
            ajax :{
            	url: "/main/user",
            	dataType : 'json',
            	data: function(q,page){
            		return {
            			search: q
            		};
            	},
            	results: function(data,page){
            		return {
            			results: data
            		};
            	}
            	
            },
            formatResult: FormatResult,
    		formatSelection: FormatSelection,
    		escapeMarkup: function (m) { return m; }
    });

    $('#newmessagebtn').on('click',function(){
    	if($('#userselect').val()=='') 
    		alert('Please Select a user to which you wish to send message');
    	else{
    		$('#sendmessage').modal()
    	}
    });

    $('#send_message_btn1').on('click',function(){

	if($('#message').val().trim()!==''){
		data = {};
		data.text = $('#message').val();
		userid = $('#userselect').val();
		
		$.post('/message/'+userid,{message: JSON.stringify(data)},function(res){
			if(res==$('#userselect').val()){
				$('#message').val('');
				$('#send_message_btn1').html('Sent');
				$('#send_message_btn1').attr('id','discard');
			}
		})
		}
	})
$(document).on('click','#discard',function(){
	
	$('#sendmessage1').modal('hide');
	$('#send_message_btn1').html('Send Message');
	$('#discard').attr('id','send_message_btn1');
	
})


	$('.reply').on('click',function(){
		var btn =$(this);
		var textarea = btn.prev().prev('textarea');
		
	if(textarea.val().trim()!==''){
		data = {};
		data.text = textarea.val();
		$.post('/message/'+btn.data('userid'),{message: JSON.stringify(data)},function(res){			
			if(res==btn.data('userid')){
				$('#messagelist'+res).append('<div class="messagetext">From me: '+ textarea.val() +'at now</div>')
				
				textarea.val('');
			}
		})
		}
	});
});

