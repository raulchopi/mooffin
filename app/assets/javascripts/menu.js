$(document).ready(function(){

	$("#login_box").hide();

	//CARGA DE PÁGINA EN PANTALLAS PEQUEÑAS
	if($(this).width() < 658){
		$(".menu").slideUp();
		$(".menu").css("border-bottom", "2px solid black");
		$(".menu").css("-webkit-box-shadow", "inset 0px 0px 50px 0px rgba(41, 43, 51, 0.25)");	
	}

	// VARIABLES
	var desplegado = false;
	var ancho = $(window).width();
	var header = $('#header');
	var content = $('#menu_principal');

	// Boton para (des)plegar el menu para dispositivos moviles
	$("#menu_movil").click(function() {
		if(desplegado){
			$(".menu").slideUp();
			desplegado = false;
		}
		else{
			$(window).scrollTop(0);
			$(".menu").slideDown();
			desplegado = true;
		}		
	});


	//Evalua si se amplia la ventana y el menu estaba plegado, que lo 
	// vuelva a desplegar para que se muestre en su nueva disposicion
	$(window).resize(function(){
	   if($(this).width() >= 658 && !desplegado){
	      	$(".menu").slideDown();
			desplegado = true;
			$(".menu").css("border-bottom", "none");
			$(".menu").css("-webkit-box-shadow", "none");
			$('#menu_principal').css('margin-top','90px');	//Se fuerza a que coja este margen
	   }
	   else if($(this).width() < 658){
	   		$(".menu").hide();
			desplegado = false;
			$(".menu").css("border-bottom", "2px solid black");
			$(".menu").css("-webkit-box-shadow", "inset 0px 0px 50px 0px rgba(41, 43, 51, 0.25)");
			$('#menu_principal').css('margin-top','120px'); //Se fuerza a que coja este margen
	   }
	});


	// COMPORTAMIENTO AL HACER SCROLL
	$(window).scroll(function () {
	    var y = $(this).scrollTop();

	    if ($(this).width() >= 658) {
	    	if (y >= 1){
		    	$(".menu").fadeOut();
				desplegado = false;
			}
	    	else if (y < 1){
				$(".menu").fadeIn();
				desplegado = true;	      
	    	}
	    }
		else if($(this).width() < 658){
			if (y >= 1){
		    	$(".menu").slideUp();
				desplegado = false;
			}
	    	else if (y < 1){
				//$("#menu").slideDown();
				//desplegado = true;	      
	    	}
		}
	});


	// HEADER BEHAVIOUR ON SCROLL
	$(window).scroll(function () {
		var y = $(this).scrollTop();

		if (y >= 1) {
			header.removeClass('big').addClass('small');
			content.css('margin-top','50px');
		}
		else{
			header.removeClass('small').addClass('big');
			marginLogin();
		}
	});

	//Aplica margen al cuadro de login en la pantalla para movil
	function marginLogin(){
		if($(this).width() >= 658){
			content.css('margin-top','90px');
		}
		else if($(this).width() < 658){
			content.css('margin-top','120px');
		}
	}

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


});