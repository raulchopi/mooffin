$("#nuevaOpinion").fadeOut 500
$("#opiniones").append("<%= escape_javascript(render(:partial => @opinion)) %>").fadeIn 500
