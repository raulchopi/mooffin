// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
  //pone una imagen al azar en la portada
  //var images = ['portada1.png'];
  //$('#imagenInicio').css({'background': 'url(../images/portada/' + images[Math.floor(Math.random() * images.length)] + ') no-repeat'});


  $("#proposal_container").hover(function(){
    $(this).children().find('.overlay').css('opacity','0.1');
  });

});




// ######  SEARCHER BEHAVIOUR ######

$(".searcher_bar").focusout(function(){
  $(".resultIngTable").fadeOut('fast');
  this.value='';
  //this.focus();
});

$("#link_ingredient").focusout(function(){  
  $(".resultIngForRecipeTable").fadeOut('fast');
  this.value='';
  //this.focus();
});

/*$(".searcher_bar").keypress(function(e) {
  var $items = $('tr');  
  
  var $viejo = $items.filter('.selected');
  var $nuevo;
  
  switch ( e.keyCode ) {
  case 38:
      $nuevo = $viejo.prev();
      break;
  case 40:
      $nuevo = $viejo.next();
      break; 
  case 13:
      // location.href = $old.find('a').attr('href');
  default:
    $items.first().addClass('selected');
  } 
  
  if ( $nuevo.is('tr') ) {
      $viejo.removeClass('selected');
      $nuevo.addClass('selected');  
  }
});*/