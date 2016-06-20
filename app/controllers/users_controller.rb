class UsersController < ApplicationController
	def new
		@overflow = false
		
		if current_user
			redirect_to(:action => 'index')
		else
			@user = User.new()
		end
		
	end
	
	def create
		user_sanitizer = Rails::Html::FullSanitizer.new
		@user = User.new(user_params)
		@user.rating = 50
		@user.votecount = 0
		@user.username = user_sanitizer.sanitize(@user.username)
		if !@user.valid?
			flash[:notice] = ["Please fix the following errors to continue."]
			@user.errors.each do |attribute, message|
				flash[:notice] << message
			end
			session[:user] = params[:user]
			redirect_to(:action => 'new')
			return
		end
		
		
		if @user.save
			UserMailer.registration_confirmation(@user).deliver
			flash[:notice] = ["Please check your email to confirm your registration."]
			redirect_to(:action => 'new')
		else
		render('new')
		end
	end

	def confirm_email
		user = User.find_by_confirm_token(params[:id])
		
		if user
			user.email_activate
			redirect_to url_for(:login)
		end
	end

	private

		def user_params
			params.require(:user).permit(:username, :password, :password_confirmation, :email)
		end
end