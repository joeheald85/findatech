$(function(){
	$('#delete_avatar').click(function(){
		$.ajax({
			url: '/users/delete_photo',
			type: 'post',
			data_type: 'json',
			success: function(){
				$('#current_photo').remove();
			}
		});
		return false;
	});
});