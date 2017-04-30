// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$('.offers.new, .offers.edit').ready(function() {
  document.getElementById('offer_country_id').addEventListener('change', function(e) {
    var country_id = e.target.value;
    $.get('/api/provinces/' + country_id);
  }, false);

  document.getElementById('preview_offer_btn').
    addEventListener('click', function(e) {
      e.preventDefault();
      var text = document.getElementById('offer_description').value;
      var container = document.getElementById('offer__preview');
      container.innerHTML = textile(text);
    }, false);
  //  changes mouse cursor when highlighting loawer right of box
  $(document).on('mousemove', 'textarea', function(e) {
    var a = $(this).offset().top + $(this).outerHeight() - 16,	//	top border of bottom-right-corner-box area
      b = $(this).offset().left + $(this).outerWidth() - 16;	//	left border of bottom-right-corner-box area
    $(this).css({
      cursor: e.pageY > a && e.pageX > b ? 'nw-resize' : ''
    });
  })
  //  the following simple make the textbox "Auto-Expand" as it is typed in
    .on('keyup', 'textarea', function(e) {
      //  the following will help the text expand as typing takes place
      while($(this).outerHeight() < this.scrollHeight + parseFloat($(this).css("borderTopWidth")) + parseFloat($(this).css("borderBottomWidth"))) {
        $(this).height($(this).height()+1);
      };
    });
});
