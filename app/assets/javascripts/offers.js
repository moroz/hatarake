// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function resetSearchForms() {
  var forms = document.forms;
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
  $('[data-province-select]').on('change', function(e) {
    document.querySelector('[data-city-input]').disabled = !this.value;
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

