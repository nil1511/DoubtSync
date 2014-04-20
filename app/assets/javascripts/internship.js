$(function(){
	$('.applyinternbtn').on('click',function(e){
		$('#internship_id').val($(this).data('iid'))

		$('#internshiplabel').html('Application for '+$(this).data('ititle'))
		console.log($(this).data('iid'),$(this).data('ititle'))
	})
})