
/*
Version 1.7.1

means there is basic unit tests for this parameter.

@name  Jeditable
@type  jQuery
@param String  target             (POST) URL or function to send edited content to **
@param Hash    options            additional options
@param String  options[method]    method to use to send edited content (POST or PUT) **
@param Function options[callback] Function to run after submitting edited content **
@param String  options[name]      POST parameter name of edited content
@param String  options[id]        POST parameter name of edited div id
@param Hash    options[submitdata] Extra parameters to send when submitting edited content.
@param String  options[type]      text, textarea or select (or any 3rd party input type) **
@param Integer options[rows]      number of rows if using textarea **
@param Integer options[cols]      number of columns if using textarea **
@param Mixed   options[height]    'auto', 'none' or height in pixels **
@param Mixed   options[width]     'auto', 'none' or width in pixels **
@param String  options[loadurl]   URL to fetch input content before editing **
@param String  options[loadtype]  Request type for load url. Should be GET or POST.
@param String  options[loadtext]  Text to display while loading external content.
@param Mixed   options[loaddata]  Extra parameters to pass when fetching content before editing.
@param Mixed   options[data]      Or content given as paramameter. String or function.**
@param String  options[indicator] indicator html to show when saving
@param String  options[tooltip]   optional tooltip text via title attribute **
@param String  options[event]     jQuery event such as 'click' of 'dblclick' **
@param String  options[submit]    submit button value, empty means no button **
@param String  options[cancel]    cancel button value, empty means no button **
@param String  options[cssclass]  CSS class to apply to input form. 'inherit' to copy from parent. **
@param String  options[style]     Style to apply to input form 'inherit' to copy from parent. **
@param String  options[select]    true or false, when true text is highlighted ??
@param String  options[placeholder] Placeholder text or html to insert when element is empty. **
@param String  options[onblur]    'cancel', 'submit', 'ignore' or function ??

@param Function options[onsubmit] function(settings, original) { ... } called before submit
@param Function options[onreset]  function(settings, original) { ... } called before reset
@param Function options[onerror]  function(settings, original, xhr) { ... } called on error

@param Hash    options[ajaxoptions]  jQuery Ajax options. See docs.jquery.com.
*/


(function() {

  (function($, window) {
    $.fn.editable = function(target, options) {
      var buttons, callback, cleanup, content, element, onedit, onerror, onreset, onsubmit, plugin, reset, settings, submit;
      if (target === "disable") {
        $(this).data("disabled.editable", true);
        return;
      }
      if (target === "enable") {
        $(this).data("disabled.editable", false);
        return;
      }
      if (target === "destroy") {
        $(this).unbind($(this).data("event.editable")).removeData("disabled.editable").removeData("event.editable");
        return;
      }
      settings = $.extend({}, $.fn.editable.defaults, {
        target: target
      }, options);
      plugin = $.editable.types[settings.type].plugin || function() {};
      submit = $.editable.types[settings.type].submit || function() {};
      buttons = $.editable.types[settings.type].buttons || $.editable.types.defaults.buttons;
      content = $.editable.types[settings.type].content || $.editable.types.defaults.content;
      element = $.editable.types[settings.type].element || $.editable.types.defaults.element;
      reset = $.editable.types[settings.type].reset || $.editable.types.defaults.reset;
      cleanup = $.editable.types[settings.type].cleanup || $.editable.types.defaults.cleanup;
      callback = settings.callback || function() {};
      onedit = settings.onedit || function() {};
      onsubmit = settings.onsubmit || function() {};
      onreset = settings.onreset || function() {};
      onerror = settings.onerror || reset;
      if (settings.tooltip) {
        $(this).attr("title", settings.tooltip);
      }
      settings.autowidth = settings.width === "auto";
      settings.autoheight = settings.height === "auto";
      return this.each(function() {
        var savedheight, savedwidth, self;
        self = this;
        savedwidth = $(self).width();
        savedheight = $(self).height();
        $(this).data("event.editable", settings.event);
        if (!$.trim($(this).html())) {
          $(this).html(settings.placeholder);
        }
        $(this).bind(settings.event, function(e) {
          var form, input, input_content, loaddata, t;
          if (true === $(this).data("disabled.editable")) {
            return;
          }
          if (self.editing) {
            return;
          }
          if (onedit.apply(this, [settings, self]) === false) {
            return;
          }
          e.preventDefault();
          e.stopPropagation();
          if (settings.tooltip) {
            $(self).removeAttr("title");
          }
          if ($(self).width() === 0) {
            settings.width = savedwidth;
            settings.height = savedheight;
          } else {
            if (settings.width !== "none") {
              settings.width = (settings.autowidth ? $(self).width() : settings.width);
            }
            if (settings.height !== "none") {
              settings.height = (settings.autoheight ? $(self).height() : settings.height);
            }
          }
          if ($(this).html().toLowerCase().replace(/(;|")/g, "") === settings.placeholder.toLowerCase().replace(/(;|")/g, "")) {
            $(this).html("");
          }
          self.editing = true;
          self.revert = $(self).html();
          $(self).html("");
          form = $("<form />");
          if (settings.cssclass) {
            if (settings.cssclass === "inherit") {
              form.attr("class", $(self).attr("class"));
            } else {
              form.attr("class", settings.cssclass);
            }
          }
          if (settings.style) {
            if (settings.style === "inherit") {
              form.attr("style", $(self).attr("style"));
              form.css("display", $(self).css("display"));
            } else {
              form.attr("style", settings.style);
            }
          }
          input = element.apply(form, [settings, self]);
          input_content = void 0;
          if (settings.loadurl) {
            t = setTimeout(function() {
              input.disabled = true;
              return content.apply(form, [settings.loadtext, settings, self]);
            }, 100);
            loaddata = {};
            loaddata[settings.id] = self.id;
            if ($.isFunction(settings.loaddata)) {
              $.extend(loaddata, settings.loaddata.apply(self, [self.revert, settings]));
            } else {
              $.extend(loaddata, settings.loaddata);
            }
            $.ajax({
              type: settings.loadtype,
              url: settings.loadurl,
              data: loaddata,
              async: false,
              success: function(result) {
                window.clearTimeout(t);
                input_content = result;
                return input.disabled = false;
              }
            });
          } else if (settings.data) {
            input_content = settings.data;
            if ($.isFunction(settings.data)) {
              input_content = settings.data.apply(self, [self.revert, settings]);
            }
          } else {
            input_content = self.revert;
          }
          content.apply(form, [input_content, settings, self]);
          input.attr("name", settings.name);
          buttons.apply(form, [settings, self]);
          $(self).append(form);
          plugin.apply(form, [settings, self]);
          $(":input:visible:enabled:first", form).focus();
          if (settings.select) {
            input.select();
          }
          input.keydown(function(e) {
            if (e.keyCode === 27) {
              e.preventDefault();
              return reset.apply(form, [settings, self]);
            }
          });
          t = void 0;
          if (settings.onblur === "cancel") {
            input.blur(function(e) {
              return t = setTimeout(function() {
                return reset.apply(form, [settings, self]);
              }, 500);
            });
          } else if (settings.onblur === "submit") {
            input.blur(function(e) {
              return t = setTimeout(function() {
                return form.submit();
              }, 200);
            });
          } else if ($.isFunction(settings.onblur)) {
            input.blur(function(e) {
              return settings.onblur.apply(self, [input.val(), settings]);
            });
          } else {
            input.blur(function(e) {});
          }
          return form.submit(function(e) {
            var ajaxoptions, str, submitdata;
            if (t) {
              clearTimeout(t);
            }
            e.preventDefault();
            if (onsubmit.apply(form, [settings, self]) !== false) {
              if (submit.apply(form, [settings, self]) !== false) {
                if ($.isFunction(settings.target)) {
                  str = settings.target.apply(self, [input.val(), settings]);
                  $(self).html(str);
                  self.editing = false;
                  callback.apply(self, [self.innerHTML, settings]);
                  if (!$.trim($(self).html())) {
                    $(self).html(settings.placeholder);
                  }
                } else {
                  submitdata = {};
                  submitdata[settings.name] = input.val();
                  submitdata[settings.id] = self.id;
                  if ($.isFunction(settings.submitdata)) {
                    $.extend(submitdata, settings.submitdata.apply(self, [self.revert, settings]));
                  } else {
                    $.extend(submitdata, settings.submitdata);
                  }
                  if (settings.method === "PUt") {
                    submitdata["_method"] = "put";
                  }
                  $(self).html(settings.indicator);
                  ajaxoptions = {
                    type: "POST",
                    data: submitdata,
                    dataType: "html",
                    url: settings.target,
                    success: function(result, status) {
                      if (ajaxoptions.dataType === "html") {
                        $(self).html(result);
                      }
                      self.editing = false;
                      callback.apply(self, [result, settings]);
                      if (!$.trim($(self).html())) {
                        return $(self).html(settings.placeholder);
                      }
                    },
                    error: function(xhr, status, error) {
                      return onerror.apply(form, [settings, self, xhr]);
                    }
                  };
                  $.extend(ajaxoptions, settings.ajaxoptions);
                  $.ajax(ajaxoptions);
                }
              }
            }
            $(self).attr("title", settings.tooltip);
            return false;
          });
        });
        return this.reset = function(form) {
          if (this.editing) {
            if (onreset.apply(form, [settings, self]) !== false) {
              $(self).html(self.revert);
              self.editing = false;
              if (!$.trim($(self).html())) {
                $(self).html(settings.placeholder);
              }
              if (settings.tooltip) {
                return $(self).attr("title", settings.tooltip);
              }
            }
          }
        };
      });
    };
    $.editable = {
      types: {
        defaults: {
          element: function(settings, original) {
            var input;
            input = $("<input type=\"hidden\"></input>");
            $(this).append(input);
            return input;
          },
          content: function(string, settings, original) {
            return $(":input:first", this).val(string);
          },
          reset: function(settings, original) {
            return original.reset(this);
          }
        }
      },
      cleanup: function(settings, original) {
        return {
          buttons: function(settings, original) {
            var cancel, form, submit;
            form = this;
            if (settings.submit) {
              if (settings.submit.match(/>$/)) {
                submit = $(settings.submit).click(function() {
                  if (submit.attr("type") !== "submit") {
                    return form.submit();
                  }
                });
              } else {
                submit = $("<button type=\"submit\" />");
                submit.html(settings.submit);
              }
              $(this).append(submit);
            }
            if (settings.cancel) {
              if (settings.cancel.match(/>$/)) {
                cancel = $(settings.cancel);
              } else {
                cancel = $("<button type=\"cancel\" />");
                cancel.html(settings.cancel);
              }
              $(this).append(cancel);
              return $(cancel).click(function(event) {
                var reset;
                if ($.isFunction($.editable.types[settings.type].reset)) {
                  reset = $.editable.types[settings.type].reset;
                } else {
                  reset = $.editable.types.defaults.reset;
                }
                reset.apply(form, [settings, original]);
                return false;
              });
            }
          }
        };
      },
      text: {
        element: function(settings, original) {
          var input;
          input = $("<input />");
          if (settings.width !== "none") {
            input.width(settings.width);
          }
          if (settings.height !== "none") {
            input.height(settings.height);
          }
          input.attr("autocomplete", "off");
          $(this).append(input);
          return input;
        }
      },
      textarea: {
        element: function(settings, original) {
          var textarea;
          textarea = $("<textarea />");
          if (settings.rows) {
            textarea.attr("rows", settings.rows);
          } else {
            if (settings.height !== "none") {
              textarea.height(settings.height);
            }
          }
          if (settings.cols) {
            textarea.attr("cols", settings.cols);
          } else {
            if (settings.width !== "none") {
              textarea.width(settings.width);
            }
          }
          $(this).append(textarea);
          return textarea;
        }
      },
      select: {
        element: function(settings, original) {
          var select;
          select = $("<select />");
          $(this).append(select);
          return select;
        },
        content: function(data, settings, original) {
          var json, key, option;
          if (String === data.constructor) {
            eval_("var json = " + data);
          } else {
            json = data;
          }
          key = void 0;
          for (key in json) {
            if (!json.hasOwnProperty(key)) {
              continue;
            }
            if (key === "selected") {
              continue;
            }
            option = $("<option />").val(key).append(json[key]);
            $("select", this).append(option);
          }
          return $("select", this).children().each(function() {
            if ($(this).val() === json["selected"] || $(this).text() === $.trim(original.revert)) {
              return $(this).attr("selected", "selected");
            }
          });
        }
      },
      addInputType: function(name, input) {
        return $.editable.types[name] = input;
      }
    };
    return $.fn.editable.defaults = {
      name: "value",
      id: "id",
      type: "text",
      width: "auto",
      height: "auto",
      event: "click.editable",
      onblur: "cancel",
      loadtype: "GET",
      loadtext: "Loading...",
      placeholder: "Click to edit",
      loaddata: {},
      submitdata: {},
      ajaxoptions: {}
    };
  })(jQuery);

}).call(this);
