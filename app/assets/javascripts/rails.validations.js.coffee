__indexOf_ = -> 
	[].indexOf or	(item) ->
		i = 0
		l = @length

		while i < l
			return i if i of this and this[i] is item
			i++
		-1

(->
	$ = jQuery
	$.fn.validate = ->
		@filter("form[data-validate]").each ->
			form = $(this)
			settings = window.ClientSideValidations.forms[form.attr("id")]
			
			addError = (element, message) ->
				ClientSideValidations.formBuilders[settings.type].add element, settings, message
			
			removeError = (element) ->
				ClientSideValidations.formBuilders[settings.type].remove element, settings
			
			form.submit (eventData) ->
				eventData.preventDefault()	unless form.isValid(settings.validators)
			
			_ref =
				"ajax:beforeSend": (eventData) ->
					form.isValid settings.validators	if eventData.target is this
				
				"form:validate:after": (eventData) ->
					ClientSideValidations.callbacks.form.after form, eventData
				
				"form:validate:before": (eventData) ->
					ClientSideValidations.callbacks.form.before form, eventData
				
				"form:validate:fail": (eventData) ->
					ClientSideValidations.callbacks.form.fail form, eventData
				
				"form:validate:pass": (eventData) ->
					ClientSideValidations.callbacks.form.pass form, eventData

			for event of _ref
				binding = _ref[event]
				form.bind event, binding

			_ref1 =
				focusout: ->
					$(this).isValid settings.validators
				
				change: ->
					$(this).data "changed", true
				

			"element:validate:after": (eventData) ->
					ClientSideValidations.callbacks.element.after $(this), eventData
			
			"element:validate:before": (eventData) ->
				 ClientSideValidations.callbacks.element.before $(this), eventData
			
			 "element:validate:fail": (eventData, message) ->
				 element = $(this)
				 ClientSideValidations.callbacks.element.fail element, message, (->
					 addError element, message), eventData
					
			 "element:validate:pass": (eventData) ->
				 element = $(this)

				 ClientSideValidations.callbacks.element.pass element, (->
					 removeError element), eventData
				
			for event of _ref1
				binding = _ref1[event]
				form.find("[data-validate=\"true\"]:input:enabled:not(:radio)").live event, binding

			form.find("[data-validate=\"true\"]:checkbox").live "click", ->
				$(this).isValid settings.validators
				true
			
			form.find("[id*=_confirmation]").each ->
				confirmationElement = $(this)
				element = form.find("#" + (@id.match(/(.+)_confirmation/)[1]) + "[data-validate='true']:input")
				if element[0]
					_ref2 =
						focusout: ->
							element.data("changed", true).isValid settings.validators
						
						keyup: ->
							element.data("changed", true).isValid settings.validators
						
					_results = []

					for event of _ref2
						binding = _ref2[event]
						_results.push $("#" + (confirmationElement.attr("id"))).live(event, binding)
					
					_results
			
		
	
	$.fn.isValid = (validators) ->
		obj = $(this[0])
		if obj.is("form")
			validateForm obj, validators
		else
			validateElement obj, validatorsFor(this[0].name, validators)
	
	validatorsFor = (name, validators) ->
		name = name.replace(/_attributes\]\[\d+\]/g, "_attributes][]")
		validators[name]
	
	validateForm = (form, validators) ->
		form.trigger "form:validate:before"
		valid = true
		form.find("[data-validate=\"true\"]:input:enabled").each ->
			valid = false	 unless $(this).isValid(validators)
			true
		
		if valid
			form.trigger "form:validate:pass"
		else
			form.trigger "form:validate:fail"
		form.trigger "form:validate:after"
		valid
	
	validateElement = (element, validators) ->
		valid = false
		element.trigger "element:validate:before"
		if element.data("changed") isnt false
			valid = true
			element.data "changed", false
			context = ClientSideValidations.validators.local
			for kind of context
				fn = context[kind]
				if validators[kind]
					_ref = validators[kind]
					_i = 0
					_len = _ref.length

					while _i < _len
						validator = _ref[_i]
						if message = fn.call(context, element, validator)
							element.trigger("element:validate:fail", message).data "valid", false
							valid = false
							break
						_i++
							
					break	 unless valid

			if valid
				context = ClientSideValidations.validators.remote
				for kind of context
					fn = context[kind]
					if validators[kind]
						_ref1 = validators[kind]
						_j = 0
						_len1 = _ref1.length

						while _j < _len1
							validator = _ref1[_j]
							if message = fn.call(context, element, validator)
								element.trigger("element:validate:fail", message).data "valid", false
								valid = false
								break
							_j++
					break	 unless valid

			if valid
				element.data "valid", null
				element.trigger "element:validate:pass"
		
		element.trigger "element:validate:after"
		element.data("valid") isnt false
	
	$ ->
		$("form[data-validate]").validate()
	

	window.ClientSideValidations =
		forms: {}
		validators:
			all: ->
				jQuery.extend {}, ClientSideValidations.validators.local, ClientSideValidations.validators.remote
			
			local:
				presence: (element, options) ->
					options.message	 if (/^\s*$/).test(element.val() or "")
				
				acceptance: (element, options) ->
					switch element.attr("type")
						when "checkbox"
							return options.message	unless element.attr("checked")
						when "text"
							options.message	 if element.val() isnt (((if (_ref = options.accept) isnt null then _ref.toString() else undefined)) or "1")
				
				format: (element, options) ->
					message = @presence(element, options)
					if message
						return	if options.allow_blank is true
						return message
					return options.message	if options["with"] and not options["with"].test(element.val())
					options.message	 if options.without and options.without.test(element.val())
				
				numericality: (element, options) ->
					val = jQuery.trim(element.val())
					unless ClientSideValidations.patterns.numericality.test(val)
						return	if options.allow_blank is true
						return options.messages.numericality
					return options.messages.only_integer	if options.only_integer and not (/^[+-]?\d+$/).test(val)
					CHECKS =
						greater_than: ">"
						greater_than_or_equal_to: ">="
						equal_to: "=="
						less_than: "<"
						less_than_or_equal_to: "<="
					
					form = $(element[0].form)
					for check of CHECKS
						operator = CHECKS[check]
						continue	unless options[check] isnt null
						if not isNaN(parseFloat(options[check])) and isFinite(options[check])
							check_value = options[check]
						else if form.find("[name*=" + options[check] + "]").size() is 1
							check_value = form.find("[name*=" + options[check] + "]").val()
						else
							return
						fn = new Function("return " + val + " " + operator + " " + check_value)
						return options.messages[check]	unless fn()
					return options.messages.odd	 if options.odd and not (parseInt(val, 10) % 2)
					options.messages.even	 if options.even and (parseInt(val, 10) % 2)
				
				length: (element, options) ->
					tokenizer = options.js_tokenizer or "split('')"
					tokenized_length = new Function("element", "return (element.val()." + tokenizer + " || '').length")(element)
					CHECKS =
						is: "=="
						minimum: ">="
						maximum: "<="

					blankOptions = {}
					blankOptions.message = (if options.is then options.messages.is else (if options.minimum then options.messages.minimum else undefined))
					message = @presence(element, blankOptions)
					if message
						return	if options.allow_blank is true
						return message
					for check of CHECKS
						operator = CHECKS[check]
						continue	unless options[check]
						fn = new Function("return " + tokenized_length + " " + operator + " " + options[check])
						return options.messages[check]	unless fn()
				
				exclusion: (element, options) ->
					message = @presence(element, options)
					if message
						return	if options.allow_blank is true
						return message
					if options["in"]
						return options.message	if _ref = element.val()
						__indexOf_((->
							_ref1 = options["in"]
							_results = []
							_i = 0
							_len = _ref1.length
						
							while _i < _len
								o = _ref1[_i]
								_results.push o.toString()
								_i++
							_results
						)(), _ref) >= 0
					if options.range
						lower = options.range[0]
						upper = options.range[1]
						options.message	 if element.val() >= lower and element.val() <= upper
				
				inclusion: (element, options) ->
					message = @presence(element, options)
					if message
						return	if options.allow_blank is true
						return message
					if options["in"]
						return	if _ref = element.val()
						__indexOf_((->
							_ref1 = options["in"]
							_results = []
							_i = 0
							_len = _ref1.length

							while _i < _len
								o = _ref1[_i]
								_results.push o.toString()
								_i++
							_results
						)(), _ref) >= 0
						
						return options.message
					if options.range
						lower = options.range[0]
						upper = options.range[1]
						return	if element.val() >= lower and element.val() <= upper
						options.message
				
				confirmation: (element, options) ->
					options.message	 if element.val() isnt jQuery("#" + (element.attr("id")) + "_confirmation").val()
				
				uniqueness: (element, options) ->
					name = element.attr("name")
					if /_attributes\]\[\d/.test(name)
						matches = name.match(/^(.+_attributes\])\[\d+\](.+)$/)
						name_prefix = matches[1]
						name_suffix = matches[2]
						value = element.val()
						if name_prefix and name_suffix
							form = element.closest("form")
							valid = true
							form.find(":input[name^=\"" + name_prefix + "\"][name$=\"" + name_suffix + "\"]").each ->
								if $(this).attr("name") isnt name
									if $(this).val() is value
										valid = false
										$(this).data "notLocallyUnique", true
									else
										$(this).removeData("notLocallyUnique").data "changed", true	 if $(this).data("notLocallyUnique")
							
							options.message	 unless valid
				
 
			remote:
				uniqueness: (element, options) ->
					message = ClientSideValidations.validators.local.presence(element, options)
					if message
						return	if options.allow_blank is true
						return message
					data = {}
					data.case_sensitive = !!options.case_sensitive
					data.id = options.id	if options.id
					if options.scope
						data.scope = {}
						_ref = options.scope
						for key of _ref
							scope_value = _ref[key]
							scoped_name = element.attr("name").replace(/\[\w+\]$/, "[" + key + "]")
							scoped_element = jQuery("[name='" + scoped_name + "']")
							if scoped_element[0] and scoped_element.val() isnt scope_value
								data.scope[key] = scoped_element.val()
								scoped_element.unbind("change." + element.id).bind "change." + element.id, ->
									element.trigger "change"
									element.trigger "focusout"
								
							else
								data.scope[key] = scope_value
					if /_attributes\]/.test(element.attr("name"))
						name = element.attr("name").match(/\[\w+_attributes\]/g).pop().match(/\[(\w+)_attributes\]/).pop()
						name += (/(\[\w+\])$/).exec(element.attr("name"))[1]
					else
						name = element.attr("name")
					name = options["class"] + "[" + name.split("[")[1]	if options["class"]
					data[name] = element.val()
					options.message	 if jQuery.ajax(
						url: "/validators/uniqueness"
						data: data
						async: false
					).status is 200
				

	 formBuilders:
			"ActionView::Helpers::FormBuilder":
				add: (element, settings, message) ->
					form = $(element[0].form)
					if element.data("valid") isnt false and (form.find("label.message[for='" + (element.attr("id")) + "']")[0]?)
						inputErrorField = jQuery(settings.input_tag)
						labelErrorField = jQuery(settings.label_tag)
						label = form.find("label[for='" + (element.attr("id")) + "']:not(.message)")
						element.attr "autofocus", false	 if element.attr("autofocus")
						element.before inputErrorField
						inputErrorField.find("span#input_tag").replaceWith element
						inputErrorField.find("label.message").attr "for", element.attr("id")
						labelErrorField.find("label.message").attr "for", element.attr("id")
						labelErrorField.insertAfter label
						labelErrorField.find("label#label_tag").replaceWith label
					form.find("label.message[for='" + (element.attr("id")) + "']").text message
				
				remove: (element, settings) ->
					form = $(element[0].form)
					errorFieldClass = jQuery(settings.input_tag).attr("class")
					inputErrorField = element.closest("." + (errorFieldClass.replace(" ", ".")))
					label = form.find("label[for='" + (element.attr("id")) + "']:not(.message)")
					labelErrorField = label.closest("." + errorFieldClass)
					if inputErrorField[0]
						inputErrorField.find("#" + (element.attr("id"))).detach()
						inputErrorField.replaceWith element
						label.detach()
						labelErrorField.replaceWith label
				
 
	 patterns:
			numericality: /^(-|\+)?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d*)?$/

		callbacks:
			element:
				after: (element, eventData) ->
				
				before: (element, eventData) ->
				
				fail: (element, message, addError, eventData) ->
					addError()
				
				pass: (element, removeError, eventData) ->
					removeError()
				
		
			form:
				after: (form, eventData) ->
				
				before: (form, eventData) ->
				
				fail: (form, eventData) ->
				
				pass: (form, eventData) ->
				
).call this