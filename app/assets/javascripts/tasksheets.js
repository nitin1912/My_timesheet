// $(function() {
//$( ".datepicker" ).datepicker();
//$( ".datepicker" ).live({
  //click: function() {
    //$( this ).datepicker({maxDate: +0});
  //}
//});


 $(function() {
$(".datepicker").datepicker({dateFormat: "yy-mm-dd"});
//$(".timepicker").timepicker();
});
//$('.timepicker').timepicker()
  //  .on('changeTime', function(ev) {
    //  alert('time has changed');
      //});

//{
  //  minutes: {
    //    interval: 15,
      //  manual: [ 0, 1, 30, 59 ]
    //},
//});
$(document).ready(function() {
        $('#submit_form').submit(function(e){
                alert('submit intercepted');
          e.preventDefault(e);
        });
 });       
