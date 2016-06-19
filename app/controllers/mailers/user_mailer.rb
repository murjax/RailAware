class UserMailer < ActionMailer::Base
	default :from => "rmurphy@railaware.com"
	
	def registration_confirmation(user)
		@user = user
		mail(:to => "#{user.username} <#{user.email}>", :subject => "Registration Confirmation")
	end
end
