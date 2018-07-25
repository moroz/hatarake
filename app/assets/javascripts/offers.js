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

var element_index = 0

document.addEventListener('turbolinks:load', function (el) {
  // substitute provinces in the province select when country is changed
  if (element_index == 0) {
    var elements = document.querySelectorAll('.nested-fields');
    elements.forEach(function(el) {
      handleLocations(el)
    });
  }

  $('#locations').on('cocoon:after-insert', function(e, insertedItem) {
    var wrapper = document.querySelectorAll('.nested-fields');
    wrapper = wrapper[wrapper.length - 1]
    handleLocations(wrapper);
  });

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
  var bodyClass = document.getElementsByTagName('body')[0].className;
  var disabledActions = ["abroad", "poland", "company_offers", "active_admin"];
  if (document.querySelectorAll('.pagination').length) {
      var included = disabledActions.some(function(action) {
          return bodyClass.includes(action);
      });
      if (included) {
          if (window.infiniteScrollSet) {
              document.removeEventListener('scroll', infiniteScroll);
              window.infiniteScrollSet = false;
          }
      } else {
          document.addEventListener('scroll', infiniteScroll);
          window.infiniteScrollSet = true;
      }
  }

  function handleLocations(el) {
    countrySelect = el.querySelector('[data-country-select]')
    countrySelect && countrySelect.addEventListener('change', function (e) {
      if (countrySelect.name != "cid") {
        var elementId = e.target.name.split('[')[2].split(']')[0];
      }
      else {
        var elementId = "search"
      }
      var countryId = e.target.value;
      if (countryId) {
        $.get('/api/provinces/' + countryId + '/' + elementId);
      }
      el.querySelector('[data-province-select]').disabled = !countryId;
      if (el.querySelector('[data-city-input]')) {
        el.querySelector('[data-city-input]').disabled = true;
      }
    }, false);
    blockCityInput(el);
    changeDestroyCheckboxName(el);
  }

  function blockCityInput(el) {
    if (!el.querySelector('[data-city-input]')) { return; }

    if (el.querySelector('[data-province-select]').value == '') {
      el.querySelector('[data-city-input]').disabled = true;
    }
    el.querySelector('[data-province-select]').addEventListener('change', function (e) {
      if (e.target.value == '') {
        el.querySelector('[data-city-input]').disabled = true;
      }
      else {
        el.querySelector('[data-city-input]').disabled = false;
      }
    });
  }

  function changeDestroyCheckboxName(el) {
    if (!el.querySelector("input[name*='[_destroy]']")) { return }
    var divId = el.querySelector('[data-country-select]').name.split('[')[2].split(']')[0];
    var destroyCheckbox = el.querySelector("input[name*='[_destroy]']");
    if (destroyCheckbox) {
      destroyCheckbox.setAttribute("name", "offer[locations_attributes][" + divId + "][_destroy]");
    }
  }

});

function infiniteScroll(e) {
    var nextLink = document.querySelector('.pagination a[rel="next"]');
    if (nextLink && nextLink.href) {
        // pure JS alternative to $(window).scrollTop()
        var scrollTop = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;
        if (scrollTop > $(document).height() - $(window).height() - 150) {
            $('.pagination').text('Loading...');
            $.getScript(nextLink.href);
        }
    }
}
