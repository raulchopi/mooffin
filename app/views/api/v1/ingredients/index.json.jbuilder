json.items do |json|
  json.array! @ingredients do |ing|
    json.id ing.id
    json.nombre ing.name
  end
end
