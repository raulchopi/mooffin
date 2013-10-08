Before('@flynn') do
  OmniAuth.config.test_mode = true
 
  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  def set_omniauth(service, opts = {})
    default = {:provider => service,
               :uuid     => "1234",
               :facebook => {
                              :email => "foobar@example.com",
                            }
              }

    credentials = default.merge(opts)
    provider = credentials[:provider]
    user_hash = credentials[provider]

    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      'uid' => credentials[:uuid],
      "extra" => {
        "user_hash" => {
          "email" => user_hash[:email],
        }
       }) }
    }
  end
end
 
After('@flynn') do
  OmniAuth.config.test_mode = false
end