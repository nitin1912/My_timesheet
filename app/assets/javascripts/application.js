// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_jquery.ui.timepicker
//= require_tree 
//= require_jquery.ui.timepicker
//= require bootstrap-timepicker
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES 
//$('.timepicker').timepicker();
Array.prototype.remByVal = function(val) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] === val) {
            this.splice(i, 1);
            i--;
        }
    }
    return this;
}


function destroy_corresponding_row(row_key){
  $('#selection_'+ row_key).remove();
  var arr = $("#array_of_row_key").val();
  var b = arr.split(',');
  b.remByVal(row_key);
 
  //$('#time').val(b.remByVal(row_key));
  $('#array_of_row_key').val(b.remByVal(row_key));
 

}


