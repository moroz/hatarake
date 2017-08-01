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

  var searchFilters = document.getElementById('search_filters');
  searchFilters && searchFilters.addEventListener('change', function(e) {
    e.stopPropagation();
    $(searchFilters).submit();
  }, false);

  // infinite scroll
  if (document.querySelectorAll('.pagination').length) {
    document.addEventListener('scroll', function (e) {
      var nextLink = document.querySelector('.pagination a[rel="next"]');
      if (nextLink && nextLink.href) {
        // pure JS alternative to $(window).scrollTop()
        var scrollTop = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;
        if (scrollTop > $(document).height() - $(window).height() - 150) {
          $('.pagination').text('Loading...');
          console.log("Getting next page at " + new Date().toTimeString());
          $.getScript(nextLink.href);
        }
      }
    }, false);
  }
});

