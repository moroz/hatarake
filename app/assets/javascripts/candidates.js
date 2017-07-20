document.addEventListener('turbolinks:load', function() {
  var el = document.getElementById('clickable_table');
  el && el.addEventListener('click', function(e) {
    var href = e.target.parentNode.dataset.link;
    href && Turbolinks.visit(href);
  }, false);
}, false);
