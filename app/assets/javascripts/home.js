// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
  //pone una imagen al azar en la portada
  //var images = ['portada1.png'];
  //$('#imagenInicio').css({'background': 'url(../images/portada/' + images[Math.floor(Math.random() * images.length)] + ') no-repeat'});

});




// ######  SEARCHER BEHAVIOUR ######

$(".searcher_bar").focusout(function(){
  //$('#buscador .bar input').css({'background-image': 'url("magnifier.png")', 'text-indent':'40px'});
  $(".resultIngTable").fadeOut('fast');
  this.value='';
  //this.focus();
});

$("#link_ingredient").focusout(function(){
  //$('#buscador .bar input').css({'background-image': 'url("magnifier.png")', 'text-indent':'40px'});
  $(".resultIngForRecipeTable").fadeOut('fast');
  this.value='';
  //this.focus();
});