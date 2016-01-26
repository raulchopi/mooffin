class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	after_filter  :set_csrf_cookie_for_ng

	def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end


	protected

	def not_authenticated
		redirect_to login_path, :alert => "Necesita iniciar sesión!"
	end

	def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

	private

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
end
