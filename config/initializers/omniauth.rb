Rails.application.config.middleware.use OmniAuth::Builder do

  provider :twitter, '0RX7PDKKMkPwkkbGsKaNhQ', 'dKiCEMdMeNQwLZIIy8wUeMaDw7Mx8f3fjbzxwQSsnWI'
  if Rails.env.production?
    provider :google_oauth2, '306861178343-44gvfs26krqj4usqj4vkfkn438kh795e.apps.googleusercontent.com', 'Ki8ddU_DfXeRFDPetmX877nA', { :image_aspect_ratio => "square", :image_size => 200 }
    provider :facebook, '1473730946221977', 'ef7ffc5bb5061cc121b20a8bb9f589de', { :secure_image_url => 'true', :image_size => 'large' }
  else
    provider :google_oauth2, '306861178343-99tuadim60lb4akbtrsv2vgr61hr44hh.apps.googleusercontent.com', 'e1G-MdVWevlcPmBPiiJfKTmP', { :image_aspect_ratio => "square", :image_size => 200 }
    provider :facebook, '1488856108046077', '3d73c12cdb2605e8be35e079118198b9', { :secure_image_url => 'true', :image_size => 'large' }
  end
end
