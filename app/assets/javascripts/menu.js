$(document).ready(function(){

	// VARIABLES
	var desplegado = false;
	var ancho = $(window).width();
	var header = $('#header');
	var content = $('#menu_principal');
	var margen_menu_ppal = '86px';

	//$("#login_box").hide();

	//CARGA DE PÁGINA EN PANTALLAS PEQUEÑAS
	if($(this).width() < 658){
		header.removeClass('big').addClass('small');
		header.css('position', 'inherit');
		$(".menu").slideUp();
		$(".menu").css("border-bottom", "2px solid black");
		$(".menu").css("-webkit-box-shadow", "inset 0px 0px 50px 0px rgba(41, 43, 51, 0.25)");
		$(".login_text").hide();
	}

	

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
			header.removeClass('small').addClass('big');
			header.css('position', 'inherit');
			$(".menu").slideDown();
			desplegado = true;
			$(".menu").css("border-bottom", "none");
			$(".menu").css("-webkit-box-shadow", "none");
			$('#menu_principal').css('margin-top', margen_menu_ppal);	//Se fuerza a que coja este margen
			$(".login_text").show();
		}
		else if($(this).width() < 658){
			header.removeClass('big').addClass('small');
			header.css('position', 'inherit');
			$(".menu").hide();
			desplegado = false;
			$(".menu").css("border-bottom", "2px solid black");
			$(".menu").css("-webkit-box-shadow", "inset 0px 0px 50px 0px rgba(41, 43, 51, 0.25)");
			$('#menu_principal').css('margin-top','50px'); //Se fuerza a que coja este margen
			$(".login_text").hide();
		}
	});


	// COMPORTAMIENTO AL HACER SCROLL
	$(window).scroll(function () {
		var y = $(this).scrollTop();

		//Comportamiento del menu
		if ($(this).width() >= 658) {
			if (y >= 1){
				$(".menu").hide();
				desplegado = false;
				header.removeClass('big').addClass('small');
				header.css('position', 'fixed');
				content.css('margin-top','50px');
			}
			else if (y < 1){
				$(".menu").fadeIn();
				desplegado = true;
				header.removeClass('small').addClass('big');
				header.css('position', 'inherit');
				marginLogin();
			}
		}
		else if($(this).width() < 658){
			if (y >= 1){
				$(".menu").slideUp();
				desplegado = false;
				header.css('position', 'fixed');
			}
			else if (y < 1){
				header.css('position', 'inherit');
			}
		}
	});


	//Aplica margen al cuadro de login en la pantalla para movil
	function marginLogin(){
		if($(this).width() >= 658){
			content.css('margin-top', margen_menu_ppal);
		}
		else if($(this).width() < 658){
			content.css('margin-top','120px');
		}
	}

});