json.id @recipe.id
json.titulo @recipe.title

json.pasos(@recipe.steps) do |step|
  json.id step.id
  json.orden step.orden
  json.desc step.description
end
