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
      marginLogin('small');
    }
    else{
      header.removeClass('small').addClass('big');
      content.css('margin-top','120px');
      marginLogin('big');
    }
  });

  //Aplica margen al cuadro de login en la pantalla para movil
  function marginLogin(size){
    if($(this).width() >= 658 || size == 'big'){
      $("#login").css("margin", "10px 0 0 0");
    }
    else if($(this).width() < 658){
      $("#login").css("margin", "10px 100px 0 0");
    }
  }


});


// ######  HEADER BEHAVIOUR ######

$(".btn_login").click(function(){
  $("#login_nav").hide();
  $("#login_box").fadeIn('slow');
});

$(".btn_close_login").click(function(){
  $("#login_box").hide();
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

$("#link_ingredient").focusout(function(){
  //$('#buscador .bar input').css({'background-image': 'url("magnifier.png")', 'text-indent':'40px'});
  $(".resultIngForRecipeTable").fadeOut('fast');
  this.value='';
  //this.focus();
});