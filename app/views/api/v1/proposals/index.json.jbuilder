json.recetas do |json|
  json.array! @proposals do |prop|
    json.id prop.id
    json.name prop.title
    json.image prop.photo_url
    json.desc prop.description
  end
end
