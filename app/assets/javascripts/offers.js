// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function safe_textilize(text) {
  result = text.replace(/</g,'&lt;').replace(/>/g,'&gt;'); // replace(/&/g,'&amp;')
  return textile(result);
}

$('.offers.new, .offers.edit').ready(function() {
  document.getElementById('offer_country_id').addEventListener('change', function(e) {
    var countryId = e.target.value;
    $.get('/api/provinces/' + countryId);
  }, false);

  document.getElementById('offer_province_id').addEventListener('change', function(e) {
    var id = e.target.value;
    var locationInput = document.getElementById('offer_location');
    if(id) {
      locationInput.disabled = false;
    } else {
      locationInput.disabled = true;
    }
  }, false);

  //  changes mouse cursor when highlighting loawer right of box
  $('#offer_description')
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
      var container = document.getElementById('offer__preview');
      container.innerHTML = safe_textilize(text);
      //  the following will help the text expand as typing takes place
      while($(this).outerHeight() < this.scrollHeight + parseFloat($(this).css("borderTopWidth")) + parseFloat($(this).css("borderBottomWidth"))) {
        $(this).height($(this).height()+1);
      };
    });
});
