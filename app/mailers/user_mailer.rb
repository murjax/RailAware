class UserMailer < ActionMailer::Base
	default :from => "RailAware <rmurphy@railaware.com>"
	
	def registration_confirmation(user)
		@user = user
		mail(:to => "#{user.username} <#{user.email}>", :subject => "Registration Confirmation")
	end
	
	def reset_password_email(user)
		@user = User.find user.id
		@url = edit_password_reset_url(@user.reset_password_token)
		mail(:to => user.email, :subject => "Your password has been reset")
	end
end
