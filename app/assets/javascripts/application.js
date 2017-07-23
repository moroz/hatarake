//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require turbolinks
//= require autocomplete-rails
//= require owl.carousel
//= require foundation.core
//= require foundation.util.mediaQuery
//= require foundation.util.keyboard.js
//= require foundation.util.triggers.js
//= require foundation.offcanvas.js

Turbolinks.changeURL = function(url) {
  Turbolinks.controller
    .pushHistoryWithLocationAndRestorationIdentifier(url, Turbolinks.uuid()); 
}

document.addEventListener('turbolinks:load', function () {
  $(document).foundation();
});

