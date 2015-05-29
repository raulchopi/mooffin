json.favoritas do |json|
  json.array! @likes do |fav|
    json.id fav.id
    json.id_receta fav.recipe_id
    json.titulo fav.recipe.title
  end
end
