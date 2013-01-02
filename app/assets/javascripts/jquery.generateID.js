(function() {

  (function($) {
    $.generateId = function() {
      return arguments_.callee.prefix + arguments_.callee.count++;
    };
    $.generateId.prefix = "jq$";
    $.generateId.count = 0;
    return $.fn.generateId = function() {
      return this.each(function() {
        return this.id = $.generateId();
      });
    };
  })(jQuery);

}).call(this);
