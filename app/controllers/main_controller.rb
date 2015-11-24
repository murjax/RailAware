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
		
		if !params[:report][:loconumber2].nil? and !params[:report][:locotype2].nil?
			if !params[:report][:loconumber3].nil? and !params[:report][:locotype3].nil?
				if !params[:report][:loconumber4].nil? and !params[:report][:locotype4].nil?
					if !params[:report][:loconumber5].nil? and !params[:report][:locotype5].nil?
						if !params[:report][:loconumber6].nil? and !params[:report][:locotype6].nil?
							@report.additional = params[:report][:loconumber2] + " " + params[:report][:locotype2] + " " + params[:report][:loconumber3] + " " + params[:report][:locotype3] + " " + params[:report][:loconumber4] + " " + params[:report][:locotype4] + " " + params[:report][:loconumber5] + " " + params[:report][:locotype5] + " " + params[:report][:loconumber6] + " " + params[:report][:locotype6]
						else
							@report.additional = params[:report][:loconumber2] + " " + params[:report][:locotype2] + " " + params[:report][:loconumber3] + " " + params[:report][:locotype3] + " " + params[:report][:loconumber4] + " " + params[:report][:locotype4] + " " + params[:report][:loconumber5] + " " + params[:report][:locotype5]
						end
					else
						@report.additional = params[:report][:loconumber2] + " " + params[:report][:locotype2] + " " + params[:report][:loconumber3] + " " + params[:report][:locotype3] + " " + params[:report][:loconumber4] + " " + params[:report][:locotype4]
					end
				else
					@report.additional = params[:report][:loconumber2] + " " + params[:report][:locotype2] + " " + params[:report][:loconumber3] + " " + params[:report][:locotype3]
				end
			else
				@report.additional = params[:report][:loconumber2] + " " + params[:report][:locotype2]
			end
		else
			@report.additional = " "
		end
		@report.location = params[:report][:city] + ", " + params[:state]
		@report.railroad = params[:railroad]
		@report.direction = params[:direction]
		@report.info = params[:report][:info]
		@report.time = DateTime.new(params[:report]["time(1i)"].to_i,params[:report]["time(2i)"].to_i,params[:report]["time(3i)"].to_i,params[:report]["time(4i)"].to_i,params[:report]["time(5i)"].to_i,0)
		@report.user_id = current_user.id
		
		if !@report.valid?
			flash[:notice] = ["You must fix the following errors to continue."]
			@report.errors.each do |attribute, message|
				flash[:notice] << message
			end
			redirect_to(:action => 'report')
			return
		end
		
		
		if @report.save
			redirect_to(:action => 'index')
		else
			render('report')
		end
	end
	
	def show
		@overflow = true
		@reports = Report.all
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
			redirect_to(:action => 'register')
			return
		end
		
		@report.username = current_user.username
		@report.user_id = current_user.id
		
		
		
		if @user.save
			redirect_to(:action => 'index')
		else
		render('register')
		end
	end
	
	private

		def user_params
			params.require(:user).permit(:username, :password, :password_confirmation, :email)
		end
		
		def report_params
			
			params.require(:report).permit(:username, :trainnumber, :loconumber, :locotype, :railroad, :location, :direction, :additional, :info, :lat, :lon, :time, :user_id)
			
		end
		
		
end
