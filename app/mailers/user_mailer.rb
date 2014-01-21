class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @greeting = "Hola"
    @url  = "http://localhost:3000/users/#{user.activation_token}/activate"
    mail(:to => user.email, :subject => "Bienvenido a Mooffin")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_success_email.subject
  #
  def activation_success_email(user)
    @user = user
    @greeting = "Hola"
    @url  = "http://localhost:3000"
    mail(:to => user.email, :subject => "Tu cuenta fue activada correctamente!")
  end
end
