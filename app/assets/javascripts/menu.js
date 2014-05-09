$(document).ready(function(){

	//CARGA DE PÁGINA EN PANTALLAS PEQUEÑAS
	if($(this).width() < 658){
		$(".menu").slideUp();
		$(".menu").css("border-bottom", "2px solid black");
		$(".menu").css("-webkit-box-shadow", "inset 0px 0px 50px 0px rgba(41, 43, 51, 0.25)");	
	}

	// VARIABLES
	var desplegado = false;
	var ancho = $(window).width();

	// Boton para (des)plegar el menu para dispositivos moviles
	$("#menu_movil").click(function() {
		if(desplegado){
			$(".menu").slideUp();
			desplegado = false;
		}
		else{
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
	   }
	   else if($(this).width() < 658){
	   		$(".menu").hide();
			desplegado = false;
			$(".menu").css("border-bottom", "2px solid black");
			$(".menu").css("-webkit-box-shadow", "inset 0px 0px 50px 0px rgba(41, 43, 51, 0.25)");
	   }
	});


	// COMPORTAMIENTO AL HACER SCROLL
	$(window).scroll(function () {
	    var y = $(this).scrollTop();

	    if ($(this).width() <= 820 && $(this).width() >= 658) {
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


});