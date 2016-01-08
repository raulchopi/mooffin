json.recetas do |json|
  json.array! @proposals do |prop|
    json.id prop.id
    json.title prop.title
    json.image prop.photo_url
    json.image_name prop.photo_file_name
    json.desc prop.description
  end
end
