// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function countHyphens(text) {
  return (text.match(/^\-\s/gm) || []).length;
}

function hyphensToAsterisks(text) {
  return text.replace(/^\-\s/gm, "* ");
}

function safe_textilize(text) {
  result = text.replace(/</g,'&lt;').replace(/>/g,'&gt;'); // replace(/&/g,'&amp;')
  return textile(result);
}

function resetSearchForms() {
  var forms = document.querySelectorAll('form');
  for (var i = 0; i < forms.length; i++) {
    forms[i].reset();
  }
}

jQuery.ajaxSetup({ cache: true }); // remove _ param from ajax requests

document.addEventListener('turbolinks:load', function () {

  // substitute provinces in the province select when country is changed
  var el = document.querySelector('[data-country-select]');
  el && el.addEventListener('change', function (e) {
    var countryId = e.target.value;
    if (countryId) {
      $.get('/api/provinces/' + countryId);
    }
    document.querySelector('[data-province-select]')
      .disabled = !countryId;
  }, false);

  // disable location field in offers#new and offers#edit
  // if no province is set
  el = document.getElementById('offer_province_id');
  el && el.addEventListener('change', function(e) {
    var locationInput = document.getElementById('offer_location');
    locationInput.disabled = !e.target.value;
  }, false);

  //  changes mouse cursor when highlighting loawer right of box
  $('[data-description-input]')
    .on('mousemove', function(e) {
      var a = $(this).offset().top + $(this).outerHeight() - 16,	//	top border of bottom-right-corner-box area
        b = $(this).offset().left + $(this).outerWidth() - 16;	//	left border of bottom-right-corner-box area
      $(this).css({
        cursor: e.pageY > a && e.pageX > b ? 'nw-resize' : ''
      });
    })
  //  the following simple make the textbox "Auto-Expand" as it is typed in
    .on('change keyup paste', function(e) {
      var text = e.target.value;
      var container = document.getElementById('description__preview');
      if ((countHyphens(text) >= 2) && !window.alreadyAsked) {
        var shouldConvert =
          confirm("It looks like there are some lists in the text. Would you like to convert it to bullets?\nWykryto wypunktowanie, czy chcesz przekonwertować je na listę?");
        window.alreadyAsked = true;
      }
      if (shouldConvert) {
        $(this).val(hyphensToAsterisks(text));
        return;
      }
      container.innerHTML = safe_textilize(text);
      //  the following will help the text expand as typing takes place
      while($(this).outerHeight() < this.scrollHeight + parseFloat($(this).css("borderTopWidth")) + parseFloat($(this).css("borderBottomWidth"))) {
        $(this).height($(this).height()+1);
      };
    });

  $('#show_advanced_search, #show_basic_search').click(function(e) {
    e.preventDefault();
    $('.basic_search, .advanced_search').toggleClass('hide');
  });

  $('[data-toggle-application-form]').click(function(e) {
    e.preventDefault();
    $('#application_form, #show_application_form').toggleClass('hide');
  });

});

