// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
  //pone una imagen al azar en la portada
  //var images = ['portada1.png'];
  //$('#imagenInicio').css({'background': 'url(../images/portada/' + images[Math.floor(Math.random() * images.length)] + ') no-repeat'});

  $("#login_box").hide();

  
  

/*
  $(window).resize(function(){
     if($(this).width() >= 658){
     }
     else if($(this).width() < 658){
     }
  });
*/


  // HEADER BEHAVIOUR ON SCROLL
  $(window).scroll(function () {
    var y = $(this).scrollTop();
    var z = $('#menu_principal').offset().top;
    var header = $('#header');
    var content = $('#menu_principal');

    if (y >= 1) {
      header.removeClass('big').addClass('small');
      content.css('margin-top','50px');
      marginLogin();
    }
    else{
      header.removeClass('small').addClass('big');
      content.css('margin-top','90px');
      marginLogin();
    }
  });

  //Aplica margen al cuadro de login en la pantalla para movil
  function marginLogin(size){
    if($(this).width() >= 658){
      $("#login").removeClass('movil');
    }
    else if($(this).width() < 658){
      $("#login").addClass('movil');
    }
  }


});


// ######  HEADER BEHAVIOUR ######

$(".btn_login").click(function(){
  $("#login_nav").hide();
  $("#login_form").fadeIn();
  $("#login_omniauth").fadeIn();
  $("#login_box").slideDown();
});

$(".btn_close_login").click(function(){  
  $("#login_form").fadeOut();
  $("#login_omniauth").fadeOut();
	$("#login_box").slideUp();
  $("#login_nav").delay(500).fadeIn();
  
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

$("#link_ingredient").focusout(function(){
  //$('#buscador .bar input').css({'background-image': 'url("magnifier.png")', 'text-indent':'40px'});
  $(".resultIngForRecipeTable").fadeOut('fast');
  this.value='';
  //this.focus();
});