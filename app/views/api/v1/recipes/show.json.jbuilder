json.id @recipe.id
json.titulo @recipe.title
json.desc @recipe.description
json.puntuacion @recipe.rating
json.tiempo @recipe.time
json.comensales @recipe.servings
json.dificultad @recipe.difficulty.description

json.usuario do |json|
  json.id @recipe.user.id
  json.nombre @recipe.user.name
  json.apellidos @recipe.user.surname
  json.nombreusuario @recipe.user.username
end

json.ingredientes(@recipe.links.order("importance_id desc")) do |link|
  json.id link.id
  json.nombre link.ingredient.name.downcase
  json.cantidad link.unidadSinCeros
  if link.unit
    json.unidades link.unit.description
  else
    json.unidades ''
  end
end

json.pasos(@recipe.steps) do |step|
  json.id step.id
  json.orden step.orden
  json.desc step.description
end
