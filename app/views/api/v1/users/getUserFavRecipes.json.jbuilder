json.favs do |json|
  json.array! @favs do |fav|
    json.id fav.recipe.id
    json.title fav.recipe.title
    json.image fav.recipe.photo_url
    json.image_name fav.recipe.photo_file_name
    json.desc fav.recipe.description
  end
end
