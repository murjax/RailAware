class MainController < ApplicationController
	layout "application"
	
	def index
		@overflow = false
		@reports = Report.all
		@hash = Gmaps4rails.build_markers(@reports) do |report, marker|
		  marker.lat report.latitude
		  marker.lng report.longitude
		  marker.infowindow "Username: " + report.username +
			"<br>" + "Train Number: " + report.trainnumber +
			"<br>" + "Locomotive Number: " + report.loconumber +
			"<br>" + "Locomotive Type: " + report.locotype +
			"<br>" + "Locomotive Railroad: " + report.railroad + 
			"<br>" + "Addtional Locomotives: " + report.additional + 
			"<br>" + "Location: " + report.location + 
			"<br>" + "Direction: " + report.direction +
			"<br>" + "Date/Time Seen: " + report.time.to_s +
			"<br>" + "Additional Info: " + report.info
			
			marker.picture({
				:url => ActionController::Base.helpers.image_path('marker.png', type: :image),
				:width => 38,
				:height => 52
			})
		end
	end
	
	def report
		@overflow = true
		
		if session[:report]
			
		end
		if !current_user
			redirect_to(:login)
		end
	end
	
	def create_report
		@report = Report.new()
		@report.username = current_user.username
		@report.trainnumber = params[:report][:trainnumber]
		@report.loconumber = params[:report][:loconumber]
		@report.locotype = params[:report][:locotype]
		
		if params[:railroad] == "Other"
			@report.railroad = params[:report][:railroad]
		else
			@report.railroad = params[:railroad]
		end
		
		if params[:railroad2] == "Other"
			params[:railroad2] = params[:report][:railroad2]
		end
		
		if params[:railroad3] == "Other"
			params[:railroad3] = params[:report][:railroad3]
		end
		
		if params[:railroad4] == "Other"
			params[:railroad4] = params[:report][:railroad4]
		end
		
		if params[:railroad5] == "Other"
			params[:railroad5] = params[:report][:railroad5]
		end
		
		if params[:railroad6] == "Other"
			params[:railroad6] = params[:report][:railroad6]
		end
		
		if !params[:report][:loconumber2].empty? and !params[:report][:locotype2].empty?
			if !params[:report][:loconumber3].empty? and !params[:report][:locotype3].empty?
				if !params[:report][:loconumber4].empty? and !params[:report][:locotype4].empty?
					if !params[:report][:loconumber5].empty? and !params[:report][:locotype5].empty?
						if !params[:report][:loconumber6].empty? and !params[:report][:locotype6].empty?
							@report.additional = params[:railroad2] + " " + params[:report][:locotype2] + " " + params[:report][:loconumber2] + ", " + params[:railroad3] + " " + params[:report][:locotype3] + " " + params[:report][:loconumber3] + ", " + params[:railroad4] + " " + params[:report][:locotype4] + " " + params[:report][:loconumber4] + ", " + params[:railroad5] + " " + params[:report][:locotype5] + " " + params[:report][:loconumber5] + ", " + params[:railroad6] + " " + params[:report][:locotype6] + " " + params[:report][:loconumber6]
						else
							@report.additional = params[:railroad2] + " " + params[:report][:locotype2] + " " + params[:report][:loconumber2] + ", " + params[:railroad3] + " " + params[:report][:locotype3] + " " +  params[:report][:loconumber3] + ", " + params[:railroad4] + " " + params[:report][:locotype4] + " " + params[:report][:loconumber4] + ", " + params[:railroad5] + " " + params[:report][:locotype5] + " " + params[:report][:loconumber5]
						end
					else
						@report.additional = params[:railroad2] + " " + params[:report][:locotype2] + " " +  params[:report][:loconumber2] + ", " + params[:railroad3] + " " + params[:report][:locotype3] + " " + params[:report][:loconumber3] + ", " + params[:railroad4] + " " + params[:report][:locotype4] + " " + params[:report][:loconumber4]
					end
				else
					@report.additional = params[:railroad2] + " " + params[:report][:locotype2] + " " + params[:report][:loconumber2] + ", " + params[:railroad3] + " " + params[:report][:locotype3] + " " + params[:report][:loconumber3]
				end
			else
				@report.additional = params[:railroad2] + " " + params[:report][:locotype2] + " " + params[:report][:loconumber2]
			end
		else
			@report.additional = " "
		end
		@report.location = params[:report][:city] + ", " + params[:state]
		
		@report.direction = params[:direction]
		@report.info = params[:report][:info]
		@report.time = DateTime.new(params[:report]["time(1i)"].to_i,params[:report]["time(2i)"].to_i,params[:report]["time(3i)"].to_i,params[:report]["time(4i)"].to_i,params[:report]["time(5i)"].to_i,0)
		@report.user_id = current_user.id
		@report.rating = "0"
		
		if !@report.valid?
			flash[:notice] = ["You must fix the following errors to continue."]
			@report.errors.each do |attribute, message|
				flash[:notice] << message
			end
			session[:report] = params[:report]
			session[:direction] = params[:direction]
			session[:state] = params[:state]
			if params[:railroad] == "Other"
				session[:railroad] = params[:report][:railroad]
			else
				session[:railroad] = params[:railroad]
			end
			
			if params[:railroad2] == "Other"
				session[:railroad2] = params[:report][:railroad2]
			else
				session[:railroad2] = params[:railroad2]
			end
			
			if params[:railroad3] == "Other"
				session[:railroad3] = params[:report][:railroad3]
			else
				session[:railroad3] = params[:railroad3]
			end
			
			if params[:railroad4] == "Other"
				session[:railroad4] = params[:report][:railroad4]
			else
				session[:railroad4] = params[:railroad4]
			end
			
			if params[:railroad5] == "Other"
				session[:railroad5] = params[:report][:railroad5]
			else
				session[:railroad5] = params[:railroad5]
			end
			
			if params[:railroad6] == "Other"
				session[:railroad6] = params[:report][:railroad6]
			else
				session[:railroad6] = params[:railroad6]
			end
			
			session[:twocheck] = params[:twocheck]
			session[:threecheck] = params[:threecheck]
			session[:fourcheck] = params[:fourcheck]
			session[:fivecheck] = params[:fivecheck]
			session[:sixcheck] = params[:sixcheck]
			
			redirect_to(:action => 'report')
			return
		end
		
		
		if @report.save
			redirect_to(:action => 'index')
		else
			render :action => 'report'
		end
	end
	
	def show
		@overflow = true
		@reports = Report.all
		@vote = Vote.all
	end
	
	
	def register
		@overflow = false
		
		if current_user
			redirect_to(:action => 'index')
		else
			@user = User.new()
		end
		
	end
	
	def create_user
		@user = User.new(user_params)
		if !@user.valid?
			flash[:notice] = ["Please fix the following errors to continue."]
			@user.errors.each do |attribute, message|
				flash[:notice] << message
			end
			session[:user] = params[:user]
			redirect_to(:action => 'register')
			return
		end
		
		
		if @user.save
			redirect_to(:action => 'index')
		else
		render('register')
		end
	end
	
	def vote
		logger.debug("Vote Received")
		flash[:notice] = ["Vote Received!"]
		
		@report = Report.find(params[:data][0])
		@rating = @report.rating.to_i
		logger.debug(@rating)
		@newrating = @rating + (params[:data][1]).to_i
		logger.debug(@newrating)
		@report.rating = @newrating
		@report.save
		
		@vote = Vote.new()
		@vote.username = current_user.username
		@vote.report_id = params[:data][0]
		@vote.save
		
		@user = User.find_by_username(current_user.username)
		@user.votecount = @user.votecount.to_i + 1
		
		if @user.votecount.to_i.between?(0, 6)
			@user.rating = (@user.rating.to_i * 0.1) + @user.rating.to_i
		elsif @user.votecount.to_i.between?(5, 11)
			@user.rating = (@user.rating.to_i * 0.08) + @user.rating.to_i
		elsif @user.votecount.to_i.between?(9, 21)
			@user.rating = (@user.rating.to_i * 0.05) + @user.rating.to_i
		elsif @user.votecount.to_i.between?(19, 41)
			@user.rating = (@user.rating.to_i * 0.03) + @user.rating.to_i
		elsif @user.votecount.to_i.between?(39, 81)
			@user.rating = (@user.rating.to_i * 0.02) + @user.rating.to_i
		else
			@user.rating = (@user.rating.to_i * 0.01) + @user.rating.to_i
		end
		
		@user.save
		
		redirect_to(:action => 'show')
	end
	
	private

		def user_params
			params.require(:user).permit(:username, :password, :password_confirmation, :email)
		end
		
		def report_params
			
			params.require(:report).permit(:username, :trainnumber, :loconumber, :locotype, :railroad, :location, :direction, :additional, :info, :lat, :lon, :time, :user_id)
			
		end
		
		
end
