// Comment format: http://tomdoc.org/, feel free to use your own

// PLUGIN_NAME
// -----------

// Short description
//
// Init options:
// [describe the init options here]
//
// Methods:
// [describe the public methods here]
//
// Properties:
// [describe the public properties here]

;
(function($, window, document, undefined) {
	'use strict'; // Enable strict JS parsing
	var version = 'v0.01';

	var DialogForm = function(method) {
		var dataKey = 'dialogForm';
		var defaults = {
			width: 700,
			height: 600,
			resizable: true,
			method: 'put',
			closeAction: "destroy",
			saveText: "Save",
			cancelText: "Cancel",
			ckid: null
		};
		var data, settings;

		this.closeDialog = function() {
			var settings = this.data(dataKey);
			if (settings.ckid) {
				var instance = CKEDITOR.instances[settings.ckid];
				if (instance) {
					instance.destroy();
				}
			}
			this.dialog(settings.closeAction);
			this.empty();
			this.trigger('dialogClosed');
			return this;
		}

		this._saveFailed = function() {
			this.trigger('linkToFormSaveFailed');
			return this;
		}

		this.handleSaveResponse = function(status, data, errorMsg, jqxhr) {
			if (status === "success") {
				console.dir(data);
				var form = $('form', this)[0];
				var url = form.action;
				$(this)
					.attr('url', form.action);
				this.closeDialog();
				this.trigger('savedAndClosed', url);
			} else {
				console.dir(status);
				console.dir(errorMsg);
				this._saveFailed();
			}
			return this;
		}

		this.doCancel = function() {
			return this.closeDialog();
		}

		this.doSave = function(evt) {
			this.trigger('beforeSave');
			var settings = this.data(dataKey);
			var form = $('form', this)[0];
			$('#' + settings.ckid, form)
				.val(CKEDITOR.instances[settings.ckid].getData());
			var formdata = $(form)
				.serialize();
			var $this = this;
			$.ajax({
				type: settings.method,
				url: form.action,
				data: formdata,
				success: function(data, status, jqxhr) {
					$this.handleSaveResponse(status, data, null, jqxhr);
				},
				error: function(jqxhr, status, errorMsg) {
					console.dir(errorMsg);
					$this.handleSaveResponse(status, null, errorMsg, jqxhr);
				}
			});
			return false;
		}

		this.createDialog = function() {
			var settings = this.data(dataKey);
			var $this = this;
			this.dialog({
				autoOpen: false,
				closeOnEscape: false,
				height: settings.height,
				width: settings.width,
				resizable: settings.resizable,
				buttons: [{
					text: settings.saveText,
					click: function() {
						$this.doSave();
					}
				}, {
					text: settings.cancelText,
					click: function() {
						$this.doCancel();
					}
				}]
			});
		}

		this.handleGet = function(jqXHR, data, error, textStatus) {
			if (textStatus !== "error") {
				this.append(data);
				this.createDialog();
				this.dialog("open");
			} else {
				alert("error")
			}
			return jqXHR;
		}

		function btnClickHandler(evt) {
			var $form = evt.data,
				btn = evt.target;
			var url = btn.href;
			var context = document.body;
			var jqxhr = $.ajax({
				method: 'GET',
				timeout: 1000,
				url: url,
				success: function(data, textStatus, jqxhr) {
					$form.handleGet(jqxhr, data, null, textStatus);
				},
				error: function(jqXHR, textStatus, error) {
					$form.handleGet(jqxhr, null, error, textStatus);
				}
			});
			return false;
		}

		this.bindLinks = function(btns) {
			btns.on('click', this, btnClickHandler);
			return this;
		}

		this.init = function(options) {
			var extended_defaults = $.extend({}, defaults, options);
			data = this.data(dataKey);

			if (!data) {
				this.data(dataKey, extended_defaults);
			}
			return this;
		}

		var methods = {
			init: this.init,
			bindLinks: this.bindLinks,
		}

		if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === 'object' || !method) {
			return methods.init.apply(this, arguments);
		} else {
			$.error('Method ' + method + ' does not exist on jQuery.dialogForm');
		}
	};

	$.fn.dialogForm = DialogForm;

})(jQuery, window, document, undefined);
