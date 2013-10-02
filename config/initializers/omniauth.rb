Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '526200534126885', '9ef00b7136fdd68277e7fb295e43855a'
  provider :twitter, '0RX7PDKKMkPwkkbGsKaNhQ', 'dKiCEMdMeNQwLZIIy8wUeMaDw7Mx8f3fjbzxwQSsnWI'
end