$(document).ready(function () {

  $('#calendar').fullCalendar({
  
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
