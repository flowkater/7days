jQuery ->
	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$('.todos-list').append($(this).data('fields').replace(regexp, time))
		event.preventDefault()

	$('form').on 'click', '.delete-btn', (event) ->
		$(this).parent().prev('input[type=hidden]').val('1')
		$(this).closest('.media').hide()
		event.preventDefault()
	
