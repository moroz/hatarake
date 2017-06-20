document.addEventListener('turbolinks:load', function () {
  var logos = document.querySelectorAll('[data-center-vertically]');
  if (logos.length > 0) {
    var setLogoContainerPadding = function(logo) {
      var container = logo.parentElement;
      container.style.paddingTop = (container.clientHeight / 2 - logo.height / 2) + 'px';
    };
    for (var i = 0; i < logos.length; i++) {
      if (logos[i].complete) {
        setLogoContainerPadding(logos[i]);
      } else {
        logos[i].addEventListener('load', setLogoContainerPadding.bind(null, logos[i]));
      }
    }
  }
});
