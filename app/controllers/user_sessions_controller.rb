class UserSessionsController < ApplicationController
  layout 'application'
  def new
	@overflow = false
	if current_user
		redirect_to(:controller => 'reports', :action => 'index')
	else
		@user = User.new
	end
	
  end

  def create
	
	if User.find_by_email(params[:email].downcase).email_confirmed
		if @user = login(params[:email], params[:password])
			# redirect_back_or_to(:main, notice: 'Login successful')
			redirect_to(:controller => 'reports', :action => 'index')
		else
			flash[:alert] = ['Login failed. Please ensure your email and password are correct.']
			session[:email] = params[:email]
			redirect_to(:action => 'new')
		end
	end
	
  end

  def destroy
	logout
	redirect_to(:controller => 'reports', :action => 'index', notice: 'Logged out!')
  end
end
