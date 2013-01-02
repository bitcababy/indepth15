(function() {

  $.editable.addInputType("ckeditor", {
    element: function(settings, original) {
      var textarea, the_id;
      the_id = settings.id || generateId();
      textarea = $("<textarea id= " + the_id + "}>");
      if (settings.rows) {
        textarea.attr("rows", settings.rows);
      } else {
        textarea.height(settings.height);
      }
      if (settings.cols) {
        textarea.attr("cols", settings.cols);
      } else {
        textarea.width(settings.width);
      }
      $(this).append(textarea);
      return textarea;
    },
    content: function(string, settings, original) {
      return $("textarea", this).text(string);
    },
    plugin: function(settings, original) {
      var self;
      self = this;
      if (settings.ckeditor) {
        return setTimeout((function() {
          return CKEDITOR.replace($("textarea", self).attr("id"), settings.ckeditor);
        }), 0);
      } else {
        return setTimeout((function() {
          return CKEDITOR.replace($("textarea", self).attr("id"));
        }), 0);
      }
    },
    submit: function(settings, original) {
      return $("textarea", this).val(CKEDITOR.instances[$("textarea", this).attr("id")].getData());
    }
  });

  ({
    cleanup: function(settings, original) {
      return CKEDITOR.instances[$("textarea", this).attr("id")].destroy();
    }
  });

}).call(this);
