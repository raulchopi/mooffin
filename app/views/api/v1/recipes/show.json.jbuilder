json.id @recipe.id
json.titulo @recipe.title
json.desc @recipe.description
json.puntuacion @recipe.rating
json.tiempo @recipe.time
json.comensales @recipe.servings
json.dificultad @recipe.difficulty.description
json.image @recipe.photo_url
json.image_name @recipe.photo_file_name

json.usuario do |json|
  json.id @recipe.user.id
  json.nombre @recipe.user.name
  json.apellidos @recipe.user.surname
  json.nombreusuario @recipe.user.username
  json.avatar @recipe.user.avatar.url
end

json.ingredientes(@recipe.links.order("importance_id desc")) do |link|
  json.id link.id
  json.nombre link.ingredient.name.downcase
  json.texto link.text_link
end

json.pasos(@recipe.steps) do |step|
  json.id step.id
  json.orden step.orden
  json.desc step.description
end

json.opiniones(@recipe.opinions) do |op|
  json.id op.id
  json.id_usuario op.user_id
  json.nombre op.user.name
  json.apellidos op.user.surname
  json.puntuacion op.rating
  json.opinion op.opinion
end
