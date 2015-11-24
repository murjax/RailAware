class UserSessionsController < ApplicationController
  layout 'application'
  def new
	@overflow = false
	if current_user
		redirect_to(:controller => 'main', :action => 'index')
	else
		@user = User.new
	end
	
  end

  def create
	if @user = login(params[:email], params[:password])
		# redirect_back_or_to(:main, notice: 'Login successful')
		redirect_to(:controller => 'main')
	else
		flash.now[:alert] = 'Login failed. Please ensure your email and password are correct.'
		render('new')
	end
  end

  def destroy
	logout
	redirect_to(:controller => 'main', notice: 'Logged out!')
  end
end
