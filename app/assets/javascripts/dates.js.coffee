#From http://www.chadcf.com/blog/jqueryui-datepicker-rails-and-simpleform-easy-way
$ ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "yy-mm-dd"
      dateFormat: "mm/dd/yy"
      altField: $(this).next()