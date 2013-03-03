
#
#Version 1.7.1
#
#means there is basic unit tests for this parameter.
#
#@name  Jeditable
#@type  jQuery
#@param String  target             (POST) URL or function to send edited content to **
#@param Hash    options            additional options
#@param String  options[method]    method to use to send edited content (POST or PUT) **
#@param Function options[callback] Function to run after submitting edited content **
#@param String  options[name]      POST parameter name of edited content
#@param String  options[id]        POST parameter name of edited div id
#@param Hash    options[submitdata] Extra parameters to send when submitting edited content.
#@param String  options[type]      text, textarea or select (or any 3rd party input type) **
#@param Integer options[rows]      number of rows if using textarea **
#@param Integer options[cols]      number of columns if using textarea **
#@param Mixed   options[height]    'auto', 'none' or height in pixels **
#@param Mixed   options[width]     'auto', 'none' or width in pixels **
#@param String  options[loadurl]   URL to fetch input content before editing **
#@param String  options[loadtype]  Request type for load url. Should be GET or POST.
#@param String  options[loadtext]  Text to display while loading external content.
#@param Mixed   options[loaddata]  Extra parameters to pass when fetching content before editing.
#@param Mixed   options[data]      Or content given as paramameter. String or function.**
#@param String  options[indicator] indicator html to show when saving
#@param String  options[tooltip]   optional tooltip text via title attribute **
#@param String  options[event]     jQuery event such as 'click' of 'dblclick' **
#@param String  options[submit]    submit button value, empty means no button **
#@param String  options[cancel]    cancel button value, empty means no button **
#@param String  options[cssclass]  CSS class to apply to input form. 'inherit' to copy from parent. **
#@param String  options[style]     Style to apply to input form 'inherit' to copy from parent. **
#@param String  options[select]    true or false, when true text is highlighted ??
#@param String  options[placeholder] Placeholder text or html to insert when element is empty. **
#@param String  options[onblur]    'cancel', 'submit', 'ignore' or function ??
#
#@param Function options[onsubmit] function(settings, original) { ... } called before submit
#@param Function options[onreset]  function(settings, original) { ... } called before reset
#@param Function options[onerror]  function(settings, original, xhr) { ... } called on error
#
#@param Hash    options[ajaxoptions]  jQuery Ajax options. See docs.jquery.com.
#
(($, window) ->
  $.fn.editable = (target, options) ->		
    if target is "disable"
      $(this).data "disabled.editable", true
      return
    if target is "enable"
      $(this).data "disabled.editable", false
      return
    if target is "destroy"
      $(this).unbind($(this).data("event.editable")).removeData("disabled.editable").removeData "event.editable"
      return
    settings = $.extend({}, $.fn.editable.defaults,
      target: target
    , options)
    plugin = $.editable.types[settings.type].plugin or ->

    submit = $.editable.types[settings.type].submit or ->

    buttons = $.editable.types[settings.type].buttons or $.editable.types.defaults.buttons
    content = $.editable.types[settings.type].content or $.editable.types.defaults.content
    element = $.editable.types[settings.type].element or $.editable.types.defaults.element
    reset = $.editable.types[settings.type].reset or $.editable.types.defaults.reset
    callback = settings.callback or ->

    onedit = settings.onedit or ->

    onsubmit = settings.onsubmit or ->

    onreset = settings.onreset or ->

    onerror = settings.onerror or reset
    $(this).attr "title", settings.tooltip  if settings.tooltip
    settings.autowidth = settings.width is "auto"
    settings.autoheight = settings.height is "auto"
    @each ->
      self = this
      savedwidth = $(self).width()
      savedheight = $(self).height()
      $(this).data "event.editable", settings.event
      $(this).html settings.placeholder  unless $.trim($(this).html())
      $(this).bind settings.event, (e) ->
        t = undefined
        return  if true is $(this).data("disabled.editable")
        return  if self.editing
        return  if onedit.apply(this, [settings, self]) is false

        e.preventDefault()
        e.stopPropagation()

        $(self).removeAttr "title"  if settings.tooltip
        if $(self).width() is 0
          settings.width = savedwidth
          settings.height = savedheight
        else
          settings.width = ((if settings.autowidth then $(self).width() else settings.width))  if settings.width isnt "none"
          settings.height = ((if settings.autoheight then $(self).height() else settings.height))  if settings.height isnt "none"

        $(this).html ""  if $(this).html().toLowerCase().replace(/(;|")/g, "") is settings.placeholder.toLowerCase().replace(/(;|")/g, "")

        self.editing = true
        self.revert = $(self).html()

        $(self).html ""

        form = $("<form />")
        if settings.cssclass
          if settings.cssclass is "inherit"
            form.attr "class", $(self).attr("class")
          else
            form.attr "class", settings.cssclass
				
        if settings.style
          if settings.style is "inherit"
            form.attr "style", $(self).attr("style")
            form.css "display", $(self).css("display")
          else
            form.attr "style", settings.style

        input = element.apply(form, [settings, self])
        input_content = undefined

        if settings.loadurl
          t = setTimeout(->
            input.disabled = true
            content.apply form, [settings.loadtext, settings, self]
          , 100)

          loaddata = {}
          loaddata[settings.id] = self.id
          if $.isFunction(settings.loaddata)
            $.extend loaddata, settings.loaddata.apply(self, [self.revert, settings])
          else
            $.extend loaddata, settings.loaddata

          $.ajax
            type: 	settings.loadtype
            url: 		settings.loadurl
            data: 	loaddata
            async: 	false
            success: (result) ->
              window.clearTimeout t
              input_content = result
              return input.disabled = false

        else if settings.data
          input_content = settings.data
          input_content = settings.data.apply(self, [self.revert, settings])  if $.isFunction(settings.data)
        else
          input_content = self.revert

        content.apply form, [input_content, settings, self]
        input.attr "name", settings.name
        buttons.apply form, [settings, self]
        $(self).append form
        plugin.apply form, [settings, self]
        $(":input:visible:enabled:first", form).focus()
        input.select()  if settings.select
				
        input.keydown (e) ->
          if e.keyCode is 27
            e.preventDefault()
            reset.apply form, [settings, self]

        t = undefined
        if settings.onblur is "cancel"
          input.blur (e) ->
            return t = setTimeout(->
              reset.apply form, [settings, self]
            , 500)

        else if settings.onblur is "submit"
          return t = input.blur (e) ->
            t = setTimeout(->
              form.submit()
            , 200)

        else if $.isFunction(settings.onblur)
          input.blur (e) ->
            settings.onblur.apply self, [input.val(), settings]

        else
          input.blur (e) ->

        form.submit (e) ->
          clearTimeout t  if t
          e.preventDefault()

          if onsubmit.apply(form, [settings, self]) isnt false
            if submit.apply(form, [settings, self]) isnt false
              if $.isFunction(settings.target)
                str = settings.target.apply(self, [input.val(), settings])
                $(self).html str
                self.editing = false
                callback.apply self, [self.innerHTML, settings]
                $(self).html settings.placeholder  unless $.trim($(self).html())

              else
                submitdata = {}
                submitdata[settings.name] = input.val()
                submitdata[settings.id] = self.id
                if $.isFunction(settings.submitdata)
                  $.extend submitdata, settings.submitdata.apply(self, [self.revert, settings])
                else
                  $.extend submitdata, settings.submitdata
                submitdata._method = "put"  if settings.method is "PUT"
                $(self).html settings.indicator

                ajaxoptions =
                  type: "POST"
                  data: submitdata
                  dataType: "html"
                  url: settings.target
                  success: (result, status) ->
                    $(self).html result  if ajaxoptions.dataType is "html"
                    self.editing = false
                    callback.apply self, [result, settings]
                    $(self).html settings.placeholder  unless $.trim($(self).html())

                  error: (xhr, status, error) ->
                    onerror.apply form, [settings, self, xhr]

                $.extend ajaxoptions, settings.ajaxoptions
                $.ajax ajaxoptions

          $(self).attr "title", settings.tooltip
          false


      return @reset = (form) ->
        if @editing
          if onreset.apply(form, [settings, self]) isnt false
            $(self).html self.revert
            self.editing = false
            $(self).html settings.placeholder  unless $.trim($(self).html())
            $(self).attr "title", settings.tooltip  if settings.tooltip


  $.editable =
    types:
      defaults:
        element: (settings, original) ->
          input = $("<input type=\"hidden\"></input>")
          $(this).append input
          input

        content: (string, settings, original) ->
          $(":input:first", this).val string

        reset: (settings, original) ->
          original.reset this

        buttons: (settings, original) ->
          form = this

          if settings.submit
            if settings.submit.match(/>$/)
              submit = $(settings.submit).click(->
                form.submit()  if submit.attr("type") isnt "submit"
              )
            else
              submit = $("<button type=\"submit\" />")
              submit.html settings.submit
            $(form).append submit

          if settings.cancel
            if settings.cancel.match(/>$/)
              cancel = $(settings.cancel)
            else
              cancel = $("<button type=\"cancel\" />")
              cancel.html settings.cancel
            $(this).append cancel
            $(cancel).click (event) ->
              if $.isFunction($.editable.types[settings.type].reset)
                reset = $.editable.types[settings.type].reset
              else
                reset = $.editable.types.defaults.reset
              reset.apply form, [settings, original]
              false

      text:
        element: (settings, original) ->
          input = $("<input />")
          input.width settings.width  if settings.width isnt "none"
          input.height settings.height  if settings.height isnt "none"
          input.attr "autocomplete", "off"
          $(this).append input
          input

      textarea:
        element: (settings, original) ->
          textarea = $("<textarea />")
          if settings.rows
            textarea.attr "rows", settings.rows
          else
            textarea.height settings.height  if settings.height isnt "none"
          if settings.cols
            textarea.attr "cols", settings.cols
          else
            textarea.width settings.width  if settings.width isnt "none"
          $(this).append textarea
          textarea

      select:
        element: (settings, original) ->
          select = $("<select />")
          $(this).append select
          select

        content: (data, settings, original) ->
          if data.constructor is String
            eval_ "json = " + data
          else
            json = data
          for key of json
            if json.hasOwnProperty(key) and key isnt "selected"
              option = $("<option />").val(key).append(json[key])
              $("select", this).append option
          $("select", this).children().each ->
            $(this).attr "selected", "selected"  if $(this).val() is json["selected"] or $(this).text() is $.trim(original.revert)

    addInputType: (name, input) ->
      $.editable.types[name] = input

  $.fn.editable.defaults =
    name: 			"value"
    id: 				"id"
    type: 			"text"
    width: 			"auto"
    height: 		"auto"
    event: 			"click.editable"
    onblur: 		"cancel"
    loadtype: 	"GET"
    loadtext: 	"Loading..."
    placeholder: "Click to edit"
    loaddata: 	{}
    submitdata: {}
    ajaxoptions: {}
) jQuery