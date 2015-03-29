/* animation for event form to create new event */

document.getElementById("trigger").addEventListener("click", function() {
    
  var split = $('.split').height();

  if( 0 === split ){
    
    $('.split').animate(
      {'height': '300px'}, 'slow'
    );
  }
  else{
    $('.split').animate(
      {'height': '0px'}, 'slow'
    );  
  }
  
}, true);

/*
$(document).ready(function(){
  
  $('.trigger').click(function(){
  
    var split = $('.split').height();

    if( 0 === split ){
    
      $('.split').animate(
        {'height': '300px'}, 'slow'
      );
    }
    else{
      $('.split').animate(
        {'height': '0px'}, 'slow'
      );
    }
    
    return false;
    
  });

});
*/
/* end animation for event form to create new event */