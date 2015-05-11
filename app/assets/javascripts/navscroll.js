$(document).scroll(function() {
  var dHeight = $(this).height()-$(window).height();
  if (dHeight >= $(this).scrollTop()) {
    $('.navbar-default').css('background', 'rgba(255,255,255,' + $(this).scrollTop()*2 / dHeight + ')');
  }
});