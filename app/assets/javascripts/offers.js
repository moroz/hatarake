// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
  document.getElementById('offer_country_id').addEventListener('change', function(e) {
    var country_id = e.target.value;
    console.log("Field changed to " + country_id + "!");
    $.get('/api/provinces/' + country_id);
  }, false)
});
