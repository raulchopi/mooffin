// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
  $("#login_form").hide();
});


// ######  HEADER BEHAVIOUR ######

$(".btn_login").click(function(){
  $("#login_nav").hide();
  $("#login_form").fadeIn('slow');
});

$(".btn_close_login").click(function(){
  $("#login_form").hide();
	$("#login_nav").fadeIn('slow');
});


// ######  SEARCHER BEHAVIOUR ######

//$(".searcher_bar").click(function(){
//  $('#buscador .bar input').css({'background-image':'none', 'text-indent':'10px'});
//});

$(".searcher_bar").focusout(function(){
  //$('#buscador .bar input').css({'background-image': 'url("magnifier.png")', 'text-indent':'40px'});
  $(".resultIngTable").fadeOut('fast');
  this.value='';
  //this.focus();
});