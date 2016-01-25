json.user do |json|
  json.id @user.id
  json.name @user.name
  json.surname @user.surname
  json.username @user.username
  json.email @user.email
  json.avatar @user.avatar.url
end
