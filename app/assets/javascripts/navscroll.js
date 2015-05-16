$(document).scroll(function() {
  var dHeight = $(this).height()-$(window).height();
  if (dHeight >= $(this).scrollTop()) {
    $('.navbar-default').css('background', 'rgba(60,60,60,' + $(this).scrollTop()*2 / dHeight + ')');
  }
});