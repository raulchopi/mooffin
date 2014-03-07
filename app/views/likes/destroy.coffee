$("#likeRecipe").html("<%= escape_javascript(render :partial => 'recipes/like') %>")
$('#<%= dom_id(@like) %>').fadeOut 500