class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_url, :notice => "Registrado!"
		else
			redirect_to signup_path, :alert => "Error en el registro!"
		end
	end

	private

		def user_params
			params.require(:user).permit(:username, :name, :surname, :email, :password)
		end
end
