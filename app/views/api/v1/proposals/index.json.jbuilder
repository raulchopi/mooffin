json.recetas do |json|
  json.array! @proposals do |prop|
    json.id prop.id
    json.nombre prop.title
  end
end
