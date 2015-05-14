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
      
      $(this).css('background-color', 'red');  
    }
    
  });
  
});

/***************************************************************************/
/***************************************************************************/

$(document).ready(function () {
  document.getElementById("open").addEventListener("click", function() {

    var split = $('.cal-form').height();

    if( 0 === split ){

    var autoHeight = $('.cal-form').css('height', 'auto').height();

    $('.cal-form').height(0).animate(
      {'height': autoHeight }, 'slow'
    );
    }
    else{
      $('.cal-form').animate(
        {'height': '0px'}, 'slow'
      );
    }

  }, true);
                                                   
});
