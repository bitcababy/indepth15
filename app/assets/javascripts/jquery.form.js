(function() {

  (function($, window) {
    /*
      Feature detection
    */

    var captureSubmittingElement, doAjaxSubmit, feature, log;
    log = function() {
      var msg;
      if (!$.fn.ajaxSubmit.debug) {
        return;
      }
      msg = "[jquery.form] " + Array.prototype.join.call(arguments_, "");
      if (window.console && window.console.log) {
        return window.console.log(msg);
      } else {
        if (window.opera && window.opera.postError) {
          return window.opera.postError(msg);
        }
      }
    };
    /*
      ajaxSubmit() provides a mechanism for immediately submitting
      an HTML form using AJAX.
    */

    /*
      ajaxForm() provides a mechanism for fully automating form submission.
      
      The advantages of using this method instead of ajaxSubmit() are:
      
      1: This method will include coordinates for <input type="image" /> elements (if the element
      is used to submit the form).
      2. This method will include the submit element's name/value data (for the element that was
      used to submit the form).
      3. This method binds the submit() method to the form for you.
      
      The options argument for ajaxForm works exactly as it does for ajaxSubmit.  ajaxForm merely
      passes the options argument along after properly binding events for submit elements and
      the form itself.
    */

    doAjaxSubmit = function(e) {
      var options;
      options = e.data;
      if (!e.isDefaultPrevented()) {
        e.preventDefault();
        return $(this).ajaxSubmit(options);
      }
    };
    captureSubmittingElement = function(e) {
      var $el, form, offset, t, target;
      target = e.target;
      $el = $(target);
      if (!$el.is("[type=submit],[type=image]")) {
        t = $el.closest("[type=submit]");
        if (t.length === 0) {
          return;
        }
        target = t[0];
      }
      form = this;
      form.clk = target;
      if (target.type === "image") {
        if (e.offsetX !== undefined) {
          form.clk_x = e.offsetX;
          form.clk_y = e.offsetY;
        } else if (typeof $.fn.offset === "function") {
          offset = $el.offset();
          form.clk_x = e.pageX - offset.left;
          form.clk_y = e.pageY - offset.top;
        } else {
          form.clk_x = e.pageX - target.offsetLeft;
          form.clk_y = e.pageY - target.offsetTop;
        }
      }
      return setTimeout((function() {
        return form.clk = form.clk_x = form.clk_y = null;
      }), 100);
    };
    "use strict";

    feature = {};
    feature.fileapi = $("<input type='file'/>").get(0).files !== undefined;
    feature.formdata = window.FormData !== undefined;
    $.fn.ajaxSubmit = function(options) {
      var $form, a, action, callbacks, deepSerialize, elements, fileAPI, fileInputs, fileUploadIframe, fileUploadXhr, hasFileInputs, jqxhr, k, method, mp, multipart, oldSuccess, q, qx, shouldUseFrame, traditional, url, veto;
      deepSerialize = function(extraData) {
        var i, len, part, result, serialized;
        serialized = $.param(extraData).split("&");
        len = serialized.length;
        result = {};
        i = void 0;
        part = void 0;
        i = 0;
        while (i < len) {
          serialized[i] = serialized[i].replace(/\+/g, " ");
          part = serialized[i].split("=");
          result[decodeURIComponent(part[0])] = decodeURIComponent(part[1]);
          i++;
        }
        return result;
      };
      fileUploadXhr = function(a) {
        var beforeSend, formdata, i, p, s, serializedData;
        formdata = new FormData();
        i = 0;
        while (i < a.length) {
          formdata.append(a[i].name, a[i].value);
          i++;
        }
        if (options.extraData) {
          serializedData = deepSerialize(options.extraData);
          for (p in serializedData) {
            if (serializedData.hasOwnProperty(p)) {
              formdata.append(p, serializedData[p]);
            }
          }
        }
        options.data = null;
        s = $.extend(true, {}, $.ajaxSettings, options, {
          contentType: false,
          processData: false,
          cache: false,
          type: method || "POST"
        });
        if (options.uploadProgress) {
          s.xhr = function() {
            var xhr;
            xhr = jQuery.ajaxSettings.xhr();
            if (xhr.upload) {
              xhr.upload.onprogress = function(event) {
                var percent, position, total;
                percent = 0;
                position = event.loaded || event.position;
                total = event.total;
                if (event.lengthComputable) {
                  percent = Math.ceil(position / total * 100);
                }
                return options.uploadProgress(event, position, total, percent);
              };
            }
            return xhr;
          };
        }
        s.data = null;
        beforeSend = s.beforeSend;
        s.beforeSend = function(xhr, o) {
          o.data = formdata;
          if (beforeSend) {
            return beforeSend.call(this, xhr, o);
          }
        };
        return $.ajax(s);
      };
      fileUploadIframe = function(a) {
        var $io, CLIENT_TIMEOUT_ABORT, SERVER_ABORT, callbackProcessed, cb, csrf_param, csrf_token, data, deferred, doSubmit, doc, domCheckCount, el, form, g, getDoc, httpData, i, id, io, n, parseJSON, s, sub, timedOut, timeoutHandle, toXml, useProp, xhr;
        getDoc = function(frame) {
          var doc;
          doc = (frame.contentWindow ? frame.contentWindow.document : (frame.contentDocument ? frame.contentDocument : frame.document));
          return doc;
        };
        doSubmit = function() {
          var checkState, extraInputs, n, t, timeoutHandle;
          checkState = function() {
            var state, timeoutHandle;
            try {
              state = getDoc(io).readyState;
              log("state = " + state);
              if (state && state.toLowerCase() === "uninitialized") {
                return setTimeout(checkState, 50);
              }
            } catch (e) {
              log("Server abort: ", e, " (", e.name, ")");
              cb(SERVER_ABORT);
              if (timeoutHandle) {
                clearTimeout(timeoutHandle);
              }
              return timeoutHandle = undefined;
            }
          };
          t = $form.attr("target");
          a = $form.attr("action");
          form.setAttribute("target", id);
          if (!method) {
            form.setAttribute("method", "POST");
          }
          if (a !== s.url) {
            form.setAttribute("action", s.url);
          }
          if (!s.skipEncodingOverride && (!method || /post/i.test(method))) {
            $form.attr({
              encoding: "multipart/form-data",
              enctype: "multipart/form-data"
            });
          }
          if (s.timeout) {
            timeoutHandle = setTimeout(function() {
              var timedOut;
              timedOut = true;
              return cb(CLIENT_TIMEOUT_ABORT);
            }, s.timeout);
          }
          extraInputs = [];
          try {
            if (s.extraData) {
              for (n in s.extraData) {
                if (s.extraData.hasOwnProperty(n)) {
                  if ($.isPlainObject(s.extraData[n]) && s.extraData[n].hasOwnProperty("name") && s.extraData[n].hasOwnProperty("value")) {
                    extraInputs.push($("<input type=\"hidden\" name=\"" + s.extraData[n].name + "\">").val(s.extraData[n].value).appendTo(form)[0]);
                  } else {
                    extraInputs.push($("<input type=\"hidden\" name=\"" + n + "\">").val(s.extraData[n]).appendTo(form)[0]);
                  }
                }
              }
            }
            if (!s.iframeTarget) {
              $io.appendTo("body");
              if (io.attachEvent) {
                io.attachEvent("onload", cb);
              } else {
                io.addEventListener("load", cb, false);
              }
            }
            setTimeout(checkState, 15);
            return form.submit();
          } finally {
            form.setAttribute("action", a);
            if (t) {
              form.setAttribute("target", t);
            } else {
              $form.removeAttr("target");
            }
            $(extraInputs).remove();
          }
        };
        cb = function(e) {
          var b, callbackProcessed, data, doc, docRoot, dt, errMsg, isXml, pre, scr, status, ta;
          if (xhr.aborted || callbackProcessed) {
            return;
          }
          try {
            doc = getDoc(io);
          } catch (ex) {
            log("cannot access response document: ", ex);
            e = SERVER_ABORT;
          }
          if (e === CLIENT_TIMEOUT_ABORT && xhr) {
            xhr.abort("timeout");
            deferred.reject(xhr, "timeout");
            return;
          } else if (e === SERVER_ABORT && xhr) {
            xhr.abort("server abort");
            deferred.reject(xhr, "error", "server abort");
            return;
          }
          if (!(!doc || doc.location.href === s.iframeSrc ? timedOut : void 0)) {
            return;
          }
          if (io.detachEvent) {
            io.detachEvent("onload", cb);
          } else {
            io.removeEventListener("load", cb, false);
          }
          status = "success";
          errMsg = void 0;
          try {
            if (timedOut) {
              throw "timeout";
            }
            isXml = s.dataType === "xml" || doc.XMLDocument || $.isXMLDoc(doc);
            log("isXml=" + isXml);
            if (!isXml && window.opera && (doc.body === null || !doc.body.innerHTML)) {
              if (--domCheckCount) {
                log("requeing onLoad callback, DOM not available");
                setTimeout(cb, 250);
                return;
              }
            }
            docRoot = (doc.body ? doc.body : doc.documentElement);
            xhr.responseText = (docRoot ? docRoot.innerHTML : null);
            xhr.responseXML = (doc.XMLDocument ? doc.XMLDocument : doc);
            if (isXml) {
              s.dataType = "xml";
            }
            xhr.getResponseHeader = function(header) {
              var headers;
              headers = {
                "content-type": s.dataType
              };
              return headers[header];
            };
            if (docRoot) {
              xhr.status = Number(docRoot.getAttribute("status")) || xhr.status;
              xhr.statusText = docRoot.getAttribute("statusText") || xhr.statusText;
            }
            dt = (s.dataType || "").toLowerCase();
            scr = /(json|script|text)/.test(dt);
            if (scr || s.textarea) {
              ta = doc.getElementsByTagName("textarea")[0];
              if (ta) {
                xhr.responseText = ta.value;
                xhr.status = Number(ta.getAttribute("status")) || xhr.status;
                xhr.statusText = ta.getAttribute("statusText") || xhr.statusText;
              } else if (scr) {
                pre = doc.getElementsByTagName("pre")[0];
                b = doc.getElementsByTagName("body")[0];
                if (pre) {
                  xhr.responseText = (pre.textContent ? pre.textContent : pre.innerText);
                } else {
                  if (b) {
                    xhr.responseText = (b.textContent ? b.textContent : b.innerText);
                  }
                }
              }
            } else {
              if (dt === "xml" && !xhr.responseXML && xhr.responseText) {
                xhr.responseXML = toXml(xhr.responseText);
              }
            }
            try {
              data = httpData(xhr, dt, s);
            } catch (e) {
              status = "parsererror";
              xhr.error = errMsg = e || status;
            }
          } catch (e) {
            log("error caught: ", e);
            status = "error";
            xhr.error = errMsg = e || status;
          }
          if (xhr.aborted) {
            log("upload aborted");
            status = null;
          }
          if (xhr.status) {
            status = (xhr.status >= 200 && xhr.status < 300 || xhr.status === 304 ? "success" : "error");
          }
          if (status === "success") {
            if (s.success) {
              s.success.call(s.context, data, "success", xhr);
            }
            deferred.resolve(xhr.responseText, "success", xhr);
            if (g) {
              $.event.trigger("ajaxSuccess", [xhr, s]);
            }
          } else if (status) {
            if (errMsg === undefined) {
              errMsg = xhr.statusText;
            }
            if (s.error) {
              s.error.call(s.context, xhr, status, errMsg);
            }
            deferred.reject(xhr, "error", errMsg);
            if (g) {
              $.event.trigger("ajaxError", [xhr, s, errMsg]);
            }
          }
          if (g) {
            $.event.trigger("ajaxComplete", [xhr, s]);
          }
          if (g && !--$.active) {
            $.event.trigger("ajaxStop");
          }
          if (s.complete) {
            s.complete.call(s.context, xhr, status);
          }
          callbackProcessed = true;
          if (s.timeout) {
            clearTimeout(timeoutHandle);
          }
          return setTimeout((function() {
            if (!s.iframeTarget) {
              $io.remove();
            }
            return xhr.responseXML = null;
          }), 100);
        };
        form = $form[0];
        el = void 0;
        i = void 0;
        s = void 0;
        g = void 0;
        id = void 0;
        $io = void 0;
        io = void 0;
        xhr = void 0;
        sub = void 0;
        n = void 0;
        timedOut = void 0;
        timeoutHandle = void 0;
        useProp = !!$.fn.prop;
        deferred = $.Deferred();
        if ($("[name=submit],[id=submit]", form).length) {
          alert("Error: Form elements must not have name or id of \"submit\".");
          deferred.reject();
          return deferred;
        }
        if (a) {
          i = 0;
          while (i < elements.length) {
            el = $(elements[i]);
            if (useProp) {
              el.prop("disabled", false);
            } else {
              el.removeAttr("disabled");
            }
            i++;
          }
        }
        s = $.extend(true, {}, $.ajaxSettings, options);
        s.context = s.context || s;
        id = "jqFormIO" + (new Date().getTime());
        if (s.iframeTarget) {
          $io = $(s.iframeTarget);
          n = $io.attr("name");
          if (!n) {
            $io.attr("name", id);
          } else {
            id = n;
          }
        } else {
          $io = $("<iframe name=\"" + id + "\" src=\"" + s.iframeSrc + "\" />");
          $io.css({
            position: "absolute",
            top: "-1000px",
            left: "-1000px"
          });
        }
        io = $io[0];
        xhr = {
          aborted: 0,
          responseText: null,
          responseXML: null,
          status: 0,
          statusText: "n/a",
          getAllResponseHeaders: function() {},
          getResponseHeader: function() {},
          setRequestHeader: function() {},
          abort: function(status) {
            var e;
            e = (status === "timeout" ? "timeout" : "aborted");
            log("aborting upload... " + e);
            this.aborted = 1;
            try {
              if (io.contentWindow.document.execCommand) {
                io.contentWindow.document.execCommand("Stop");
              }
            } catch (_error) {}
            $io.attr("src", s.iframeSrc);
            xhr.error = e;
            if (s.error) {
              s.error.call(s.context, xhr, e, status);
            }
            if (g) {
              $.event.trigger("ajaxError", [xhr, s, e]);
            }
            if (s.complete) {
              return s.complete.call(s.context, xhr, e);
            }
          }
        };
        g = s.global;
        if (g && 0 === $.active++) {
          $.event.trigger("ajaxStart");
        }
        if (g) {
          $.event.trigger("ajaxSend", [xhr, s]);
        }
        if (s.beforeSend && s.beforeSend.call(s.context, xhr, s) === false) {
          if (s.global) {
            $.active--;
          }
          deferred.reject();
          return deferred;
        }
        if (xhr.aborted) {
          deferred.reject();
          return deferred;
        }
        sub = form.clk;
        if (sub) {
          n = sub.name;
          if (n && !sub.disabled) {
            s.extraData = s.extraData || {};
            s.extraData[n] = sub.value;
            if (sub.type === "image") {
              s.extraData[n + ".x"] = form.clk_x;
              s.extraData[n + ".y"] = form.clk_y;
            }
          }
        }
        CLIENT_TIMEOUT_ABORT = 1;
        SERVER_ABORT = 2;
        csrf_token = $("meta[name=csrf-token]").attr("content");
        csrf_param = $("meta[name=csrf-param]").attr("content");
        if (csrf_param && csrf_token) {
          s.extraData = s.extraData || {};
          s.extraData[csrf_param] = csrf_token;
        }
        if (s.forceSync) {
          doSubmit();
        } else {
          setTimeout(doSubmit, 10);
        }
        data = void 0;
        doc = void 0;
        domCheckCount = 50;
        callbackProcessed = void 0;
        toXml = $.parseXML || function(s, doc) {
          if (window.ActiveXObject) {
            doc = new ActiveXObject("Microsoft.XMLDOM");
            doc.async = "false";
            doc.loadXML(s);
          } else {
            doc = (new DOMParser()).parseFromString(s, "text/xml");
          }
          if (doc && doc.documentElement && doc.documentElement.nodeName !== "parsererror") {
            return doc;
          } else {
            return null;
          }
        };
        parseJSON = $.parseJSON || function(s) {
          return window["eval"]("(" + s + ")");
        };
        httpData = function(xhr, type, s) {
          var ct, xml;
          ct = xhr.getResponseHeader("content-type") || "";
          xml = type === "xml" || !type && ct.indexOf("xml") >= 0;
          data = (xml ? xhr.responseXML : xhr.responseText);
          if (xml && data.documentElement.nodeName === "parsererror" ? $.error : void 0) {
            $.error("parsererror");
          }
          if (s && s.dataFilter) {
            data = s.dataFilter(data, type);
          }
          if (typeof data === "string") {
            if (type === "json" || !type && ct.indexOf("json") >= 0) {
              data = parseJSON(data);
            } else {
              if (type === "script" || !type && ct.indexOf("javascript") >= 0) {
                $.globalEval(data);
              }
            }
          }
          return data;
        };
        return deferred;
      };
      if (!this.length) {
        log("ajaxSubmit: skipping submit process - no element selected");
        return this;
      }
      method = void 0;
      action = void 0;
      url = void 0;
      $form = this;
      if (typeof options === "function") {
        options = {
          success: options
        };
      }
      method = this.attr("method");
      action = this.attr("action");
      url = (typeof action === "string" ? $.trim(action) : "");
      url = url || window.location.href || "";
      if (url) {
        url = (url.match(/^([^#]+)/) || [])[1];
      }
      options = $.extend(true, {
        url: url,
        success: $.ajaxSettings.success,
        type: method || "GET",
        iframeSrc: (/^https/i.test(window.location.href || "") ? "javascript:false" : "about:blank")
      }, options);
      veto = {};
      this.trigger("form-pre-serialize", [this, options, veto]);
      if (veto.veto) {
        log("ajaxSubmit: submit vetoed via form-pre-serialize trigger");
        return this;
      }
      if (options.beforeSerialize && options.beforeSerialize(this, options) === false) {
        log("ajaxSubmit: submit aborted via beforeSerialize callback");
        return this;
      }
      traditional = options.traditional;
      if (traditional === undefined) {
        traditional = $.ajaxSettings.traditional;
      }
      elements = [];
      qx = void 0;
      a = this.formToArray(options.semantic, elements);
      if (options.data) {
        options.extraData = options.data;
        qx = $.param(options.data, traditional);
      }
      if (options.beforeSubmit && options.beforeSubmit(a, this, options) === false) {
        log("ajaxSubmit: submit aborted via beforeSubmit callback");
        return this;
      }
      this.trigger("form-submit-validate", [a, this, options, veto]);
      if (veto.veto) {
        log("ajaxSubmit: submit vetoed via form-submit-validate trigger");
        return this;
      }
      q = $.param(a, traditional);
      if (qx) {
        q = (q ? q + "&" + qx : qx);
      }
      if (options.type.toUpperCase() === "GET") {
        options.url += (options.url.indexOf("?") >= 0 ? "&" : "?") + q;
        options.data = null;
      } else {
        options.data = q;
      }
      callbacks = [];
      if (options.resetForm) {
        callbacks.push(function() {
          return $form.resetForm();
        });
      }
      if (options.clearForm) {
        callbacks.push(function() {
          return $form.clearForm(options.includeHidden);
        });
      }
      if (!options.dataType && options.target) {
        oldSuccess = options.success || function() {};
        callbacks.push(function(data) {
          var fn;
          fn = (options.replaceTarget ? "replaceWith" : "html");
          return $(options.target)[fn](data).each(oldSuccess, arguments_);
        });
      } else {
        if (options.success) {
          callbacks.push(options.success);
        }
      }
      options.success = function(data, status, xhr) {
        var context, i, max, _results;
        context = options.context || this;
        i = void 0;
        max = callbacks.length;
        i = 0;
        _results = [];
        while (i < max) {
          callbacks[i].apply(context, [data, status, xhr || $form, $form]);
          _results.push(i++);
        }
        return _results;
      };
      fileInputs = $("input[type=file]:enabled[value!=\"\"]", this);
      hasFileInputs = fileInputs.length > 0;
      mp = "multipart/form-data";
      multipart = $form.attr("enctype") === mp || $form.attr("encoding") === mp;
      fileAPI = feature.fileapi && feature.formdata;
      log("fileAPI :" + fileAPI);
      shouldUseFrame = (hasFileInputs || multipart) && !fileAPI;
      jqxhr = void 0;
      if (options.iframe !== false && (options.iframe || shouldUseFrame)) {
        if (options.closeKeepAlive) {
          $.get(options.closeKeepAlive, function() {
            return jqxhr = fileUploadIframe(a);
          });
        } else {
          jqxhr = fileUploadIframe(a);
        }
      } else if ((hasFileInputs || multipart) && fileAPI) {
        jqxhr = fileUploadXhr(a);
      } else {
        jqxhr = $.ajax(options);
      }
      $form.removeData("jqxhr").data("jqxhr", jqxhr);
      k = 0;
      while (k < elements.length) {
        elements[k] = null;
        k++;
      }
      this.trigger("form-submit-notify", [this, options]);
      return this;
    };
    $.fn.ajaxForm = function(options) {
      var o;
      options = options || {};
      options.delegation = options.delegation && $.isFunction($.fn.on);
      if (!options.delegation && this.length === 0) {
        o = {
          s: this.selector,
          c: this.context
        };
        if (!$.isReady && o.s) {
          log("DOM not ready, queuing ajaxForm");
          $(function() {
            return $(o.s, o.c).ajaxForm(options);
          });
          return this;
        }
        log("terminating; zero elements found by selector" + ($.isReady ? "" : " (DOM not ready)"));
        return this;
      }
      if (options.delegation) {
        $(document).off("submit.form-plugin", this.selector, doAjaxSubmit).off("click.form-plugin", this.selector, captureSubmittingElement).on("submit.form-plugin", this.selector, options, doAjaxSubmit).on("click.form-plugin", this.selector, options, captureSubmittingElement);
        return this;
      }
      return this.ajaxFormUnbind().bind("submit.form-plugin", options, doAjaxSubmit).bind("click.form-plugin", options, captureSubmittingElement);
    };
    $.fn.ajaxFormUnbind = function() {
      return this.unbind("submit.form-plugin click.form-plugin");
    };
    /*
      formToArray() gathers form element data into an array of objects that can
      be passed to any of the following ajax functions: $.get, $.post, or load.
      Each object in the array has both a 'name' and 'value' property.  An example of
      an array for a simple login form might be:
      
      [ { name: 'username', value: 'jresig' }, { name: 'password', value: 'secret' } ]
      
      It is this array that is passed to pre-submit callback functions provided to the
      ajaxSubmit() and ajaxForm() methods.
    */

    $.fn.formToArray = function(semantic, elements) {
      var $input, a, el, els, files, form, i, input, j, jmax, max, n, v;
      a = [];
      if (this.length === 0) {
        return a;
      }
      form = this[0];
      els = (semantic ? form.getElementsByTagName("*") : form.elements);
      if (!els) {
        return a;
      }
      i = void 0;
      j = void 0;
      n = void 0;
      v = void 0;
      el = void 0;
      max = void 0;
      jmax = void 0;
      i = 0;
      max = els.length;
      while (i < max) {
        el = els[i];
        n = el.name;
        if (!n) {
          continue;
        }
        if (semantic && form.clk && el.type === "image") {
          if (!el.disabled && form.clk === el) {
            a.push({
              name: n,
              value: $(el).val(),
              type: el.type
            });
            a.push({
              name: n + ".x",
              value: form.clk_x
            }, {
              name: n + ".y",
              value: form.clk_y
            });
          }
          continue;
        }
        v = $.fieldValue(el, true);
        if (v && v.constructor === Array) {
          if (elements) {
            elements.push(el);
          }
          j = 0;
          jmax = v.length;
          while (j < jmax) {
            a.push({
              name: n,
              value: v[j]
            });
            j++;
          }
        } else if (feature.fileapi && el.type === "file" && !el.disabled) {
          if (elements) {
            elements.push(el);
          }
          files = el.files;
          if (files.length) {
            j = 0;
            while (j < files.length) {
              a.push({
                name: n,
                value: files[j],
                type: el.type
              });
              j++;
            }
          } else {
            a.push({
              name: n,
              value: "",
              type: el.type
            });
          }
        } else if (v !== null && typeof v !== "undefined") {
          if (elements) {
            elements.push(el);
          }
          a.push({
            name: n,
            value: v,
            type: el.type,
            required: el.required
          });
        }
        i++;
      }
      if (!semantic && form.clk) {
        $input = $(form.clk);
        input = $input[0];
        n = input.name;
        if (n && !input.disabled && input.type === "image") {
          a.push({
            name: n,
            value: $input.val()
          });
          a.push({
            name: n + ".x",
            value: form.clk_x
          }, {
            name: n + ".y",
            value: form.clk_y
          });
        }
      }
      return a;
    };
    /*
      Serializes form data into a 'submittable' string. This method will return a string
      in the format: name1=value1&amp;name2=value2
    */

    $.fn.formSerialize = function(semantic) {
      return $.param(this.formToArray(semantic));
    };
    /*
      Serializes all field elements in the jQuery object into a query string.
      This method will return a string in the format: name1=value1&amp;name2=value2
    */

    $.fn.fieldSerialize = function(successful) {
      var a;
      a = [];
      this.each(function() {
        var i, max, n, v, _results;
        n = this.name;
        if (!n) {
          return;
        }
        v = $.fieldValue(this, successful);
        if (v && v.constructor === Array) {
          i = 0;
          max = v.length;
          _results = [];
          while (i < max) {
            a.push({
              name: n,
              value: v[i]
            });
            _results.push(i++);
          }
          return _results;
        } else if (v !== null && typeof v !== "undefined") {
          return a.push({
            name: this.name,
            value: v
          });
        }
      });
      return $.param(a);
    };
    /*
      Returns the value(s) of the element in the matched set.  For example, consider the following form:
      
      <form><fieldset>
      <input name="A" type="text" />
      <input name="A" type="text" />
      <input name="B" type="checkbox" value="B1" />
      <input name="B" type="checkbox" value="B2"/>
      <input name="C" type="radio" value="C1" />
      <input name="C" type="radio" value="C2" />
      </fieldset></form>
      
      var v = $('input[type=text]').fieldValue();
      // if no values are entered into the text inputs
      v == ['','']
      // if values entered into the text inputs are 'foo' and 'bar'
      v == ['foo','bar']
      
      var v = $('input[type=checkbox]').fieldValue();
      // if neither checkbox is checked
      v === undefined
      // if both checkboxes are checked
      v == ['B1', 'B2']
      
      var v = $('input[type=radio]').fieldValue();
      // if neither radio is checked
      v === undefined
      // if first radio is checked
      v == ['C1']
      
      The successful argument controls whether or not the field element must be 'successful'
      (per http://www.w3.org/TR/html4/interact/forms.html#successful-controls).
      The default value of the successful argument is true.  If this value is false the value(s)
      for each element is returned.
      
      Note: This method *always* returns an array.  If no valid value can be determined the
      array will be empty, otherwise it will contain one or more values.
    */

    $.fn.fieldValue = function(successful) {
      var el, i, max, v, val;
      val = [];
      i = 0;
      max = this.length;
      while (i < max) {
        el = this[i];
        v = $.fieldValue(el, successful);
        if (v === null || typeof v === "undefined" || (v.constructor === Array && !v.length)) {
          continue;
        }
        if (v.constructor === Array) {
          $.merge(val, v);
        } else {
          val.push(v);
        }
        i++;
      }
      return val;
    };
    /*
      Returns the value of the field element.
    */

    $.fieldValue = function(el, successful) {
      var a, i, index, max, n, one, op, ops, t, tag, v;
      n = el.name;
      t = el.type;
      tag = el.tagName.toLowerCase();
      if (successful === undefined) {
        successful = true;
      }
      if (successful && (!n || el.disabled || t === "reset" || t === "button" || (t === "checkbox" || t === "radio") && !el.checked || (t === "submit" || t === "image") && el.form && el.form.clk !== el || tag === "select" && el.selectedIndex === -1)) {
        return null;
      }
      if (tag === "select") {
        index = el.selectedIndex;
        if (index < 0) {
          return null;
        }
        a = [];
        ops = el.options;
        one = t === "select-one";
        max = (one ? index + 1 : ops.length);
        i = (one ? index : 0);
        while (i < max) {
          op = ops[i];
          if (op.selected) {
            v = op.value;
            if (!v) {
              v = (op.attributes && op.attributes["value"] && !op.attributes["value"].specified ? op.text : op.value);
            }
            if (one) {
              return v;
            }
            a.push(v);
          }
          i++;
        }
        return a;
      }
      return $(el).val();
    };
    /*
      Clears the form data.  Takes the following actions on the form's input fields:
      - input text fields will have their 'value' property set to the empty string
      - select elements will have their 'selectedIndex' property set to -1
      - checkbox and radio inputs will have their 'checked' property set to false
      - inputs of type submit, button, reset, and hidden will *not* be effected
      - button elements will *not* be effected
    */

    $.fn.clearForm = function(includeHidden) {
      return this.each(function() {
        return $("input,select,textarea", this).clearFields(includeHidden);
      });
    };
    /*
      Clears the selected form elements.
    */

    $.fn.clearFields = $.fn.clearInputs = function(includeHidden) {
      var re;
      re = /^(?:color|date|datetime|email|month|number|password|range|search|tel|text|time|url|week)$/i;
      return this.each(function() {
        var t, tag;
        t = this.type;
        tag = this.tagName.toLowerCase();
        if (re.test(t) || tag === "textarea") {
          return this.value = "";
        } else if (t === "checkbox" || t === "radio") {
          return this.checked = false;
        } else if (tag === "select") {
          return this.selectedIndex = -1;
        } else if (t === "file") {
          if ($.browser.msie) {
            return $(this).replaceWith($(this).clone());
          } else {
            return $(this).val("");
          }
        } else {
          if (includeHidden ? (includeHidden === true && /hidden/.test(t)) || (typeof includeHidden === "string" && $(this).is(includeHidden)) : void 0) {
            return this.value = "";
          }
        }
      });
    };
    /*
      Resets the form data.  Causes all form elements to be reset to their original value.
    */

    $.fn.resetForm = function() {
      return this.each(function() {
        if (typeof this.reset === "function" || (typeof this.reset === "object" && !this.reset.nodeType)) {
          return this.reset();
        }
      });
    };
    /*
      Enables or disables any matching elements.
    */

    $.fn.enable = function(b) {
      if (b === undefined) {
        b = true;
      }
      return this.each(function() {
        return this.disabled = !b;
      });
    };
    /*
      Checks/unchecks any matching checkboxes or radio buttons and
      selects/deselects and matching option elements.
    */

    $.fn.selected = function(select) {
      if (select === undefined) {
        select = true;
      }
      return this.each(function() {
        var $sel, t;
        t = this.type;
        if (t === "checkbox" || t === "radio") {
          return this.checked = select;
        } else if (this.tagName.toLowerCase() === "option") {
          $sel = $(this).parent("select");
          if (select && $sel[0] && $sel[0].type === "select-one") {
            $sel.find("option").selected(false);
          }
          return this.selected = select;
        }
      });
    };
    return $.fn.ajaxSubmit.debug = false;
  })(jQuery);

}).call(this);
