class UsersController < ApplicationController

	before_action :get_user, only: [:show, :userrecipes]

	def get_user
		@user = User.find(params[:id])
	end

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

	def userrecipes
		@user = User.find(userrecipes_params)
		@recipes = @user.recipes
		respond_to do |format|
			format.json {
				render json: @recipes.to_json(:methods => [:photo_url])
			}
			format.html {
				@recipes
			}
			end
	end

	def update
	end

	def show
		@recipes = @user.recipes
	end

	private

		def user_params
			params.require(:user).permit(:username, :name, :surname, :email, :password, :avatar)
		end

		def userrecipes_params
			params.require(:id)
		end
end
