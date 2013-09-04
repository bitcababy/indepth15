(function($, window, document) {
	"use strict";
	var defaults = {
			width: 700,
			height: 600,
			resizable: true,
			method: 'put',
			closeAction: "destroy",
			saveText: "Save",
			cancelText: "Cancel",
			ckid: null,
	};

	var privateMethods = {

		_closeDialog: function() {
			var settings = $(this).data('settings');
			if (settings.ckid) {
				var instance = CKEDITOR.instances[settings.ckid];
				if (instance) {
					instance.destroy();
				}
			}
	    this.dialog(settings.closeAction);
	    this.empty();
	    return this;
		},

		_doCancel: function() {
			this.closeDialog();
			return this;
		},

		_doSave: function(evt) {
			var that = this;
			var form = $('form', this);
			var ckid = $(this).data('ckid');
			var url = $(form).attr('action');
			$(that).data('url', url);

			// Load the textarea from the ckeditor
			// $('#' + ckid, this).val(CKEDITOR.instances[ckid].getData());
			$(form).on('ajax:success', function(evt, data, status, xhr){
	      that._closeDialog();
				that.trigger('savedAndClosed', url);
			});
			$(form).on('ajax:failure', function(evt, data, status, xhr){
				// TODO: fill this out!
			});
			$(form).submit();
			return this;
		},

		_createDialog: function() {
			var that = this;
			var settings = $(this).data('settings');
	    this.dialog({
	      autoOpen: false,
	      closeOnEscape: false,
	      height: settings.height,
	      width: settings.width,
	      resizable: settings.resizable,
				buttons: [
	        {
	          text: settings.saveText,
	          click: function(evt) { that._doSave(evt); }
	        }, {
	          text: settings.cancelText,
	          click: function(evt) { that.doCancel(evt); }
					}
	      ]}
			);
			return this;
		},

		_handleBtnClick: function(evt) {
			$(this).data('formURL', evt.target.href);
			$(this).create();
		}
	};
	
	var handleBtnClick = function(evt) {
		var form = evt.data;
		$(form)._handleBtnClick(evt);
	}

	var methods = {
		// This should not be in here, but we'll leave it for now
		create: function(evt) {
			var that = this;
			// TODO: handle failure
			$.get(that.data('formURL'), function(data, textStatus, jqXHR) {
				that.append(data);
		  	that._createDialog();
		  	that.dialog("open");
			});
			return this;
	  },

		bindLinks: function(btns) {
			var that = this;
			btns.bind('dialogForm.click', this, handleBtnClick);
			return this;
		},
		
		options: function(option, name) {
			
		},
		init: function(options) {
			var settings = $.extend({}, defaults, options);
			// TODO: filter settings
			$(this).data('settings', settings);
			$.extend(this, privateMethods);
			$(this)[0].modalForm = this;
			return this;
		},
	};

	$.fn.modalForm = function(method) {
	  if ( methods[method] ) {
	    return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
		}
	  if ( typeof method === 'object' || ! method ) {
	    return methods.init.apply( this, arguments );
	  }
	  $.error( 'Method ' +  method + ' does not exist on jQuery.dialogForm' );
	};
	
})(jQuery, window, document);
