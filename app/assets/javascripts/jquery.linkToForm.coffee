(($) ->
	create_dialog = (settings) ->
		settings.div.dialog
			autoOpen: 	settings.autoOpen
			height: 		settings.height
			width: 			settings.width
			modal: 			settings.modal
			resizable: 	settings.resizable
			closeOnEscape: false
			buttons:		settings.btns

	handleGetFormError = (settings) ->
		if settings.error and typeof(settings.error) is "function"
			settings.error()
		else
			alert "Error!"
		# TODO: Handle an error

	handleGetForm = (status, data, errorMsg, jqxhr, settings) ->
		if status is "success"
			# Add the form to the div
			div = settings.div
			div.append(data)
			# Create the dialog
			create_dialog(settings)
			# And open it
			div.dialog "open"
		else
			handleGetFormError()

	handle_btn_click = (evt, settings) ->
		# The url will load the form
		$.ajax
			url: 			evt.target.href
			type: 		'GET'
			dataType: 'html'
			success:	(data, status, jqxhr) -> 
				handleGetForm(status, data, null, jqxhr, settings)
				return false
			error:		(jqxhr, status, errorMsg) -> 
				handleGetForm(status, null, errorMsg, jqxhr, settings)
				return false
		return false

  methods = 
		link: (options) ->
			@each ->
				$this = $(this)
				data = $this.data "linkToForm"
	    
				# If the plugin hasn't been initialized yet
				unless data
					$this.data "linkToForm", options
				logger.dir $(this)
				$this.on 'click', $this.data "linkToForm", handle_btn_click
					
	##
	## Dispatch function
	##
  $.fn.linkToForm = (method) ->
    console.dir methods
    if methods[method]
	 	  methods[method].apply this, Array::slice.call(arguments, 1)
	 		else if typeof method is "object" or not method
	 			methods.init.apply this, arguments_
	 		else
	  		$.error "Method " + method + " does not exist on jQuery.linkToForm"
	) jQuery
