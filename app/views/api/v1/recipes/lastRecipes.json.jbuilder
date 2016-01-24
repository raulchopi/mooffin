json.lastRecipes do |json|
  json.array! @lastRecipes do |rec|
    json.id rec.id
    json.title rec.title
    json.image rec.photo_url
    json.image_name rec.photo_file_name
    json.desc rec.description
  end
end
