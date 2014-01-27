class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception


	protected

	def not_authenticated
		redirect_to login_path, :alert => "Necesita iniciar sesión!" 
	end

	private  
	
	def current_user  
		@current_user ||= User.find(session[:user_id]) if session[:user_id]  
	end 
end
