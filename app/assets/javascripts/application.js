// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require jquery-readyselector
//= require turbolinks
//= require textile
//= require autocomplete-rails
//= require foundation
//= require_tree .

document.addEventListener('turbolinks:load', function () {
  $(document).foundation();
});

$(document).on('ajax:before', 'form[method=get][data-remote=true]', function(e) {
  e.preventDefault(); // do not perform regular sumbit
  e.stopPropagation(); // do not let regular remote handler see this
  var form = $(this);
  Turbolinks.visit(form.attr("action") + form.serialize());
});

(function(){
  var remoteForm = 'form[method!=get][data-remote=true]';
  $(document).on('submit', remoteForm, function(e, response) {
    Turbolinks.controller.history.push(window.location.href);
  });

  $(document).on('ajax:success', remoteForm, function(e, response) {
    if(response.substring(0, 10) == 'Turbolinks'){ return; }
    Turbolinks.clearCache();
    $("body").html(response.match(/<body[^>]*>([\s\S]*?)<\/body>/i)[1]);
    Turbolinks.dispatch("turbolinks:load");
    window.scroll(0, 0);
  });
})();
