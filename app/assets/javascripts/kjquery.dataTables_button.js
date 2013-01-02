(function() {

  $.fn.dataTableExt.oPagination.four_button = {
    fnInit: function(oSettings, nPaging, fnCallbackDraw) {
      var nFirst, nLast, nNext, nPrevious;
      nFirst = document.createElement("span");
      nPrevious = document.createElement("span");
      nNext = document.createElement("span");
      nLast = document.createElement("span");
      nFirst.appendChild(document.createTextNode(oSettings.oLanguage.oPaginate.sFirst));
      nPrevious.appendChild(document.createTextNode(oSettings.oLanguage.oPaginate.sPrevious));
      nNext.appendChild(document.createTextNode(oSettings.oLanguage.oPaginate.sNext));
      nLast.appendChild(document.createTextNode(oSettings.oLanguage.oPaginate.sLast));
      nFirst.className = "paginate_button first";
      nPrevious.className = "paginate_button previous";
      nNext.className = "paginate_button next";
      nLast.className = "paginate_button last";
      nPaging.appendChild(nFirst);
      nPaging.appendChild(nPrevious);
      nPaging.appendChild(nNext);
      nPaging.appendChild(nLast);
      $(nFirst).click(function() {
        oSettings.oApi._fnPageChange(oSettings, "first");
        return fnCallbackDraw(oSettings);
      });
      $(nPrevious).click(function() {
        oSettings.oApi._fnPageChange(oSettings, "previous");
        return fnCallbackDraw(oSettings);
      });
      $(nNext).click(function() {
        oSettings.oApi._fnPageChange(oSettings, "next");
        return fnCallbackDraw(oSettings);
      });
      $(nLast).click(function() {
        oSettings.oApi._fnPageChange(oSettings, "last");
        return fnCallbackDraw(oSettings);
      });
      $(nFirst).bind("selectstart", function() {
        return false;
      });
      $(nPrevious).bind("selectstart", function() {
        return false;
      });
      $(nNext).bind("selectstart", function() {
        return false;
      });
      return $(nLast).bind("selectstart", function() {
        return false;
      });
    },
    fnUpdate: function(oSettings, fnCallbackDraw) {
      var an, buttons, i, iLen, _results;
      if (!oSettings.aanFeatures.p) {
        return;
      }
      an = oSettings.aanFeatures.p;
      i = 0;
      iLen = an.length;
      _results = [];
      while (i < iLen) {
        buttons = an[i].getElementsByTagName("span");
        if (oSettings._iDisplayStart === 0) {
          buttons[0].className = "paginate_disabled_previous";
          buttons[1].className = "paginate_disabled_previous";
        } else {
          buttons[0].className = "paginate_enabled_previous";
          buttons[1].className = "paginate_enabled_previous";
        }
        if (oSettings.fnDisplayEnd() === oSettings.fnRecordsDisplay()) {
          buttons[2].className = "paginate_disabled_next";
          buttons[3].className = "paginate_disabled_next";
        } else {
          buttons[2].className = "paginate_enabled_next";
          buttons[3].className = "paginate_enabled_next";
        }
        _results.push(i++);
      }
      return _results;
    }
  };

}).call(this);
