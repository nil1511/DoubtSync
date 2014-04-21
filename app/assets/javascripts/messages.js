$(function(){

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

