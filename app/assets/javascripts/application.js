//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require jquery.remotipart
//= require turbolinks
//= require autocomplete-rails
//= require owl.carousel
//= require foundation.core
//= require foundation.util.mediaQuery
//= require foundation.util.keyboard.js
//= require foundation.util.triggers.js
//= require foundation.util.box.js
//= require foundation.util.nest.js
//= require foundation.offcanvas.js
//= require foundation.dropdownMenu.js
//= require offers
//= require companies
//= require cookies_eu
//= require jquery.rateyo.js
//= require candidates
//= require Markdown.Converter
//= require Markdown.Sanitizer
//= require Markdown.Editor
//= require Jcrop
//= require avatars

Turbolinks.changeURL = function(url) {
  Turbolinks.controller
    .pushHistoryWithLocationAndRestorationIdentifier(url, Turbolinks.uuid()); 
}

document.addEventListener('turbolinks:load', function () {
  $(document).foundation();
});

function toggleSelection(name, state) {
  boxes = document.getElementsByName(name);
  for (var i=0, n=boxes.length; i < n; i++) {
    boxes[i].checked = state;
  }
}

