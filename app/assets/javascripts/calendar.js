$(document).ready(function () {

  $('#calendar').fullCalendar({
    
    eventSources: [{
      url: '/cal'
    }],
  
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
               
    dayClick: function( date, allDay, jsEvent, view ) { 
                                   
      alert(date);
      
      $(this).css('background-color', 'red');  
    }      
                
  });
  
});

/***************************************************************************/
/***************************************************************************/
$(document).ready(function () {
  document.getElementById("open").addEventListener("click", function() {

    var split = $('.cal').height();

    if( 0 === split ){

    var autoHeight = $('.cal').css('height', 'auto').height();

    $('.cal').height(0).animate(
      {'height': autoHeight }, 'slow'
    );
    }
    else{
      $('.cal').animate(
        {'height': '0px'}, 'slow'
      );
    }

  }, true);
});
