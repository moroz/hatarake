function submitOnCtrlEnter(e) {
  if (e.ctrlKey && (e.keyCode == 10 || e.keyCode == 13)) {
    $(e.target.form).trigger('submit.rails');
  }
}

function resizeTextarea(e) {
  e.target.style.height = '1px';
  e.target.style.height = (16+e.target.scrollHeight)+'px';
}

document.addEventListener('turbolinks:load', function(e) {
  var ta = document.querySelector(".new_blog_post__textarea");
  ta && ta.addEventListener('keydown', submitOnCtrlEnter);
  $(ta).on('change keyup input', resizeTextarea);
});
