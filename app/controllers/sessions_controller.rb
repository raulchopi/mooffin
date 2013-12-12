class SessionsController < ApplicationController
	
	before_action :set_user, only: [:create]
	before_action :require_login, only: [:destroy]

	def new
		@user = User.new
	end

	def create  
		if @user
			redirect_back_or_to root_url , :notice => "Sesión iniciada!"  
		else  
			redirect_to root_url, :alert => "Usuario o contraseña incorrecto!" 
		end  
	end

	def destroy
		logout
		redirect_to root_url, :notice => 'Sesión cerrada!'
	end

	private
		def set_user
			@user = login(params[:sessions][:username], params[:sessions][:password])
		end

		def session_params
			params.require(:username).permit(:email, :password)
		end
end