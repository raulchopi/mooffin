Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '526200534126885', '9ef00b7136fdd68277e7fb295e43855a'
  provider :twitter, '0RX7PDKKMkPwkkbGsKaNhQ', 'dKiCEMdMeNQwLZIIy8wUeMaDw7Mx8f3fjbzxwQSsnWI'
  if Rails.env.production?
    provider :google_oauth2, '306861178343-44gvfs26krqj4usqj4vkfkn438kh795e.apps.googleusercontent.com', 'Ki8ddU_DfXeRFDPetmX877nA'
  else  
    provider :google_oauth2, '306861178343-99tuadim60lb4akbtrsv2vgr61hr44hh.apps.googleusercontent.com', 'e1G-MdVWevlcPmBPiiJfKTmP'
  end
end