// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


// ######  HEADER BEHAVIOUR ######

$(document).ready(function(){
	$("#login_form").hide();
});

$(".btn_login").click(function(){
    $("#login_nav").hide();
	$("#login_form").fadeIn('slow');
  });

$(".btn_close_login").click(function(){
    $("#login_form").hide();
	$("#login_nav").fadeIn('slow');
  });
