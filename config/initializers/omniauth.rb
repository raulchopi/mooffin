Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '526200534126885', '9ef00b7136fdd68277e7fb295e43855a'
  provider :twitter, '0RX7PDKKMkPwkkbGsKaNhQ', 'dKiCEMdMeNQwLZIIy8wUeMaDw7Mx8f3fjbzxwQSsnWI'
  provider :google_oauth2, '306861178343-5e80rvct55cvacc9c3429br5hnob03fg.apps.googleusercontent.com', '24e1e4d92afc881bf0a9fc2dad904e602a3b4492'
end