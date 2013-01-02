(function() {

  $(function() {
    return $("input.datepicker").each(function(i) {
      return $(this).datepicker({
        altFormat: "yy-mm-dd",
        dateFormat: "mm/dd/yy",
        altField: $(this).next()
      });
    });
  });

}).call(this);
