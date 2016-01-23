class MainController < ApplicationController
	layout "application"
	
	def index
		@overflow = false
		@reports = Report.where(:created_at => (1.week.ago..Time.zone.now))
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
			"<br>" + "Date/Time Seen: " + report.time.strftime("%m/%d/%Y - %H:%M") + " " + report.timezone +
			"<br>" + "Additional Info: " + report.info
			
			marker.picture({
				:url => ActionController::Base.helpers.image_path('marker.png', type: :image),
				:width => 15,
				:height => 20
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
	
	def edit
		@oldreport = Report.find(params[:id])
		@overflow = true
		
		if !session[:report]
			
		end
		
		if !current_user
			redirect_to(:login)
		end
		
		if @oldreport.username != current_user.username
			redirect_to(:viewreports)
		end
		
		if !(DateTime.now.beginning_of_day..DateTime.now.end_of_day).cover? @oldreport.time
			redirect_to(:viewreports)
		end
	end
	
	def create_report
		full_sanitizer = Rails::Html::FullSanitizer.new
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
						
						
							if params[:direction2] == "Front"
								if params[:direction3] == "Front"
									if params[:direction4] == "Front"
										if params[:direction5] == "Front"
											if params[:direction6] == "Front"
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										else
											if params[:direction6] == "Front"
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										end
									else
										if params[:direction5] == "Front"
											if params[:direction6] == "Front"
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										else
											if params[:direction6] == "Front"
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										end
									end
								else
									if params[:direction4] == "Front"
										if params[:direction5] == "Front"
											if params[:direction6] == "Front"
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else	
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										else
											if params[:direction6] == "Front"
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										end
									else
										if params[:direction5] == "Front"
											if params[:direction6] == "Front"
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										else
											if params[:direction6] == "Front"
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										end
									end
								end
							else
								if params[:direction3] == "Front"
									if params[:direction4] == "Front"
										if params[:direction5] == "Front"
											if params[:direction6] == "Front"
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										else	
											if params[:direction6] == "Front"
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										end
									else
										if params[:direction5] == "Front"
											if params[:direction6] == "Front"
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										else	
											if params[:direction6] == "Front"
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										end
									end
								else
									if params[:direction4] == "Front"
										if params[:direction5] == "Front"
											if params[:direction6] == "Front"
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										else
											if params[:direction6] == "Front"
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										end
									else
										if params[:direction5] == "Front"
											if params[:direction6] == "Front"
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										else
											if params[:direction6] == "Front"
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											else
												@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad6]) + " " + full_sanitizer.sanitize(params[:report][:locotype6]) + " " + full_sanitizer.sanitize(params[:report][:loconumber6])
											end
										end
									end
								end
							end
						
							
							
							
							
							
							
						else
							if params[:direction2] == "Front"
								if params[:direction3] == "Front"
									if params[:direction4] == "Front"
										if params[:direction5] == "Front"
											@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										else
											@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										end
									else
										if params[:direction5] == "Front"
											@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										else
											@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										end
									end
								else
									if params[:direction4] == "Front"
										if params[:direction5] == "Front"
											@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										else
											@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										end
									else
										if params[:direction5] == "Front"
											@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										else
											@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										end
									end
								end
							else
								if params[:direction3] == "Front"
									if params[:direction4] == "Front"
										if params[:direction5] == "Front"
											@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										else
											@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										end
									else
										if params[:direction5] == "Front"
											@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										else
											@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										end
									end
								else
									if params[:direction4] == "Front"
										if params[:direction5] == "Front"
											@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										else
											@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										end
									else
										if params[:direction5] == "Front"
											@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										else
											@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad5]) + " " + full_sanitizer.sanitize(params[:report][:locotype5]) + " " + full_sanitizer.sanitize(params[:report][:loconumber5])
										end
									end
								end
							end
						end
					else
						if params[:direction2] == "Front"
							if params[:direction3] == "Front"
								if params[:direction4] == "Front"
									@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4])
								else
									@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4])
								end
							else
								if params[:direction4] == "Front"
									@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4])
								else
									@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4])
								end
							end
						else
							if params[:direction3] == "Front"
								if params[:direction4] == "Front"
									@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4])
								else
									@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " +full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4])
								end
							else
								if params[:direction4] == "Front"
									@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4])
								else
									@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " +  full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad4]) + " " + full_sanitizer.sanitize(params[:report][:locotype4]) + " " + full_sanitizer.sanitize(params[:report][:loconumber4])
								end
							end
						end
					end
				else
					if params[:direction2] == "Front"
						if params[:direction3] == "Front"
							@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3])
						else
							@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">>" + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3])
						end
					else
						if params[:direction3] == "Front"
							@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + "<< " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3])
						else
							@report.additional = ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2]) + ", " + ">> " + full_sanitizer.sanitize(params[:railroad3]) + " " + full_sanitizer.sanitize(params[:report][:locotype3]) + " " + full_sanitizer.sanitize(params[:report][:loconumber3])
						end
					end
				end
			else
				if params[:direction2] == "Front"
					@report.additional = "<< " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2])
				else
					@report.additional =  ">> " + full_sanitizer.sanitize(params[:railroad2]) + " " + full_sanitizer.sanitize(params[:report][:locotype2]) + " " + full_sanitizer.sanitize(params[:report][:loconumber2])
				end
				
			end
		else
			@report.additional = " "
		end
		logger.debug(params[:manuallocation])
		if params[:report][:latitude].empty?
			if params[:country] == "Canada"
				@report.location = params[:report][:city] + ", " + params[:province]
			else
				@report.location = params[:report][:city] + ", " + params[:state]
			end
			
		else
			if params[:manuallocation]
				if params[:country] == "Canada"
					@report.location = params[:report][:city] + ", " + params[:province]
				else
					@report.location = params[:report][:city] + ", " + params[:state]
				end
			else
				@report.latitude = params[:report][:latitude]
				@report.longitude = params[:report][:longitude]
			end
			
		end
		
		
		
		@report.direction = params[:direction]
		@report.info = params[:report][:info]
		@report.time = Time.new(params[:report]["time(1i)"].to_i,params[:report]["time(2i)"].to_i,params[:report]["time(3i)"].to_i,params[:report]["time(4i)"].to_i,params[:report]["time(5i)"].to_i,0)
		@report.user_id = current_user.id
		@report.rating = "0"
		
		@report.trainnumber = full_sanitizer.sanitize(@report.trainnumber)
		@report.loconumber = full_sanitizer.sanitize(@report.loconumber)
		@report.locotype = full_sanitizer.sanitize(@report.locotype)
		@report.railroad = full_sanitizer.sanitize(@report.railroad)
		@report.location = full_sanitizer.sanitize(@report.location)
		@report.info = full_sanitizer.sanitize(@report.info)
		
		if params[:railroadsuggestion]
			File.open("railroadsuggestions.txt", "a") { |file| file.write params[:report][:railroad] + " " + params[:report][:railroad2] + " " + params[:report][:railroad3] + " " + params[:report][:railroad4] + " " + params[:report][:railroad5] + " " + params[:report][:railroad6]}
		end
		if !@report.valid?
			flash[:notice] = ["You must fix the following errors to continue."]
			@report.errors.each do |attribute, message|
				flash[:notice] << message
			end
			session[:report] = params[:report]
			session[:direction] = params[:direction]
			session[:direction2] = params[:direction2]
			session[:direction3] = params[:direction3]
			session[:direction4] = params[:direction4]
			session[:direction5] = params[:direction5]
			session[:direction6] = params[:direction6]
			session[:state] = params[:state]
			session[:province] = params[:province]
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
			timezone = Timezone::Zone.new :latlon => [@report.latitude.to_s, @report.longitude.to_s]
			if timezone.zone == "America/St_Johns"
				@report.timezone = "NT"
			elsif timezone.zone == "America/Moncton" || timezone.zone == "America/Blanc-Sablon" || timezone.zone == "America/Glace_Bay"
				@report.timezone = "AT"
			elsif timezone.zone == "America/New_York" || timezone.zone == "America/Toronto" || timezone.zone == "America/Detroit" || timezone.zone == "America/Fort_Wayne" || timezone.zone == "America/Indiana/Indianapolis" || timezone.zone == "America/Indiana/Marengo" || timezone.zone == "America/Indiana/Petersburg" || timezone.zone == "America/Indiana/Vevay" || timezone.zone == "America/Indiana/Winamac" || timezone.zone == "America/Indianapolis" || timezone.zone == "America/Kentucky/Louisville" || timezone.zone == "America/Kentucky/Monticello" || timezone.zone == "America/Louisville" || timezone.zone == "America/Atikokan" || timezone.zone == "America/Iqaluit" || timezone.zone == "America/Nipigon" || timezone.zone == "America/Thunder_Bay"
				@report.timezone = "ET"
			elsif timezone.zone == "America/Chicago" || timezone.zone == "America/Winnipeg" || timezone.zone == "America/Regina" || timezone.zone == "America/Indiana/Knox" || timezone.zone == "America/Indiana/Tell_City" || timezone.zone == "America/Indiana/Vincennes" || timezone.zone == "America/Knox_IN" || timezone.zone == "America/North_Dakota/Beulah" || timezone.zone == "America/North_Dakota/New_Salem" || timezone.zone == "America/North_Dakota/Center" || timezone.zone == "America/Inuvik" || timezone.zone == "America/Rainy_River" || timezone.zone == "America/Rankin_Inlet" || timezone.zone == "America/Resolute" || timezone.zone == "America/Swift_Current"
				@report.timezone = "CT"
			elsif timezone.zone == "America/Denver" || timezone.zone == "America/Phoenix" || timezone.zone == "America/Edmonton" || timezone.zone == "America/Shiprock" || timezone.zone == "America/Boise"
				@report.timezone = "MT"
			elsif timezone.zone == "America/Los_Angeles" || timezone.zone == "America/Vancouver" || timezone.zone == "America/Creston" || timezone.zone == "America/Dawson" || timezone.zone == "America/Dawson_Creek" || timezone.zone == "America/Fort_Nelson" || timezone.zone == "America/Cambridge_Bay" || timezone.zone == "America/Whitehorse"
				@report.timezone = "PT"
			elsif timezone.zone == "America/Anchorage" || timezone.zone == "America/Juneau" || timezone.zone == "America/Nome" || timezone.zone == "America/Adak" || timezone.zone == "America/Atka" || timezone.zone == "America/Sitka"
				@report.timezone = "AKT"
			elsif timezone.zone == "Pacific/Honolulu"
				@report.timezone = "HT"
			else
				flash[:notice] = ["You must fix the following errors to continue."]
				flash[:notice] << "Location invalid. We only support reporting within the United States and Canada at this time."
				@report.destroy
				redirect_to(:action => 'report')
				return
			end
			
			@absoluteoffset = timezone.utc_offset.to_i.abs
			@offset = Time.at(@absoluteoffset).utc.strftime("-%H:%M")
			@offset = @offset.to_s
			@checktime = Time.new(params[:report]["time(1i)"].to_i,params[:report]["time(2i)"].to_i,params[:report]["time(3i)"].to_i,params[:report]["time(4i)"].to_i,params[:report]["time(5i)"].to_i, 0, @offset)
			
			logger.debug(@checktime)
			logger.debug(Time.now.in_time_zone(timezone.active_support_time_zone))
			
			if @checktime > Time.now.in_time_zone(timezone.active_support_time_zone)
				flash[:notice] = ["You must fix the following errors to continue."]
				flash[:notice] << "Invalid time. Time cannot be in the future."
				@report.destroy
				redirect_to(:action => 'report')
				return
			end
			
			@duplicatetimecheck = Report.where(created_at: 1.hours.ago..Time.now)
			if @duplicatetimecheck.length > 1
				@duplicatelocationcheck = @duplicatetimecheck.where(location: @report.location)
				if @duplicatelocationcheck.length > 1
					@duplicatetraincheck = @duplicatelocationcheck.where(trainnumber: @report.trainnumber)
					if @duplicatetraincheck.length > 1
						flash[:notice] = ["You must fix the following errors to continue."]
						flash[:notice] << "This train has already been reported by a user."
						@report.destroy
						redirect_to(:action => 'report')
						return
					end
				end
			end
			if (Time.now-1.hours..Time.now).cover? @checktime
				if Report.find_by_location(@report.location)
					
				end
			end
			@report.save
			logger.debug(timezone.zone)
			redirect_to(:action => 'index')
		else
			render :action => 'report'
		end
	end
	
	def update_report
		@report = Report.find(params[:report][:id])
		@newreport = Report.new()
		
		@newreport.username = @report.username
		@newreport.trainnumber = @report.trainnumber
		@newreport.loconumber = @report.loconumber
		@newreport.locotype = @report.locotype
		@newreport.railroad = @report.railroad
		@newreport.direction = params[:direction]
		@newreport.additional = @report.additional
		@newreport.info = @report.info
		@newreport.time = Time.new(params[:report]["time(1i)"].to_i,params[:report]["time(2i)"].to_i,params[:report]["time(3i)"].to_i,params[:report]["time(4i)"].to_i,params[:report]["time(5i)"].to_i,0)
		@newreport.user_id = current_user.id
		@report.rating = @report.rating
		
		if params[:report][:latitude].empty?
			if params[:country] == "Canada"
				@newreport.location = params[:report][:city] + ", " + params[:province]
			else
				@newreport.location = params[:report][:city] + ", " + params[:state]
			end
			
		else
			if params[:manuallocation]
				if params[:country] == "Canada"
					@newreport.location = params[:report][:city] + ", " + params[:province]
				else
					@newreport.location = params[:report][:city] + ", " + params[:state]
				end
			else
				@newreport.latitude = params[:report][:latitude]
				@newreport.longitude = params[:report][:longitude]
			end
			
		end
		
		if @newreport.save
			@report.destroy
			timezone = Timezone::Zone.new :latlon => [@newreport.latitude.to_s, @newreport.longitude.to_s]
			if timezone.zone == "America/St_Johns"
				@newreport.timezone = "NT"
			elsif timezone.zone == "America/Moncton" || timezone.zone == "America/Blanc-Sablon" || timezone.zone == "America/Glace_Bay"
				@newreport.timezone = "AT"
			elsif timezone.zone == "America/New_York" || timezone.zone == "America/Toronto" || timezone.zone == "America/Detroit" || timezone.zone == "America/Fort_Wayne" || timezone.zone == "America/Indiana/Indianapolis" || timezone.zone == "America/Indiana/Marengo" || timezone.zone == "America/Indiana/Petersburg" || timezone.zone == "America/Indiana/Vevay" || timezone.zone == "America/Indiana/Winamac" || timezone.zone == "America/Indianapolis" || timezone.zone == "America/Kentucky/Louisville" || timezone.zone == "America/Kentucky/Monticello" || timezone.zone == "America/Louisville" || timezone.zone == "America/Atikokan" || timezone.zone == "America/Iqaluit" || timezone.zone == "America/Nipigon" || timezone.zone == "America/Thunder_Bay"
				@newreport.timezone = "ET"
			elsif timezone.zone == "America/Chicago" || timezone.zone == "America/Winnipeg" || timezone.zone == "America/Regina" || timezone.zone == "America/Indiana/Knox" || timezone.zone == "America/Indiana/Tell_City" || timezone.zone == "America/Indiana/Vincennes" || timezone.zone == "America/Knox_IN" || timezone.zone == "America/North_Dakota/Beulah" || timezone.zone == "America/North_Dakota/New_Salem" || timezone.zone == "America/North_Dakota/Center" || timezone.zone == "America/Inuvik" || timezone.zone == "America/Rainy_River" || timezone.zone == "America/Rankin_Inlet" || timezone.zone == "America/Resolute" || timezone.zone == "America/Swift_Current"
				@newreport.timezone = "CT"
			elsif timezone.zone == "America/Denver" || timezone.zone == "America/Phoenix" || timezone.zone == "America/Edmonton" || timezone.zone == "America/Shiprock" || timezone.zone == "America/Boise"
				@newreport.timezone = "MT"
			elsif timezone.zone == "America/Los_Angeles" || timezone.zone == "America/Vancouver" || timezone.zone == "America/Creston" || timezone.zone == "America/Dawson" || timezone.zone == "America/Dawson_Creek" || timezone.zone == "America/Fort_Nelson" || timezone.zone == "America/Cambridge_Bay" || timezone.zone == "America/Whitehorse"
				@newreport.timezone = "PT"
			elsif timezone.zone == "America/Anchorage" || timezone.zone == "America/Juneau" || timezone.zone == "America/Nome" || timezone.zone == "America/Adak" || timezone.zone == "America/Atka" || timezone.zone == "America/Sitka"
				@newreport.timezone = "AKT"
			elsif timezone.zone == "Pacific/Honolulu"
				@newreport.timezone = "HT"
			else
				flash[:notice] = ["You must fix the following errors to continue."]
				flash[:notice] << "Location invalid. We only support reporting within the United States and Canada at this time. Please recreate your report."
				@newreport.destroy
				redirect_to(:action => 'report')
				return
			end
			
			@absoluteoffset = timezone.utc_offset.to_i.abs
			@offset = Time.at(@absoluteoffset).utc.strftime("-%H:%M")
			@offset = @offset.to_s
			@checktime = Time.new(params[:report]["time(1i)"].to_i,params[:report]["time(2i)"].to_i,params[:report]["time(3i)"].to_i,params[:report]["time(4i)"].to_i,params[:report]["time(5i)"].to_i, 0, @offset)
			
			logger.debug(@checktime)
			logger.debug(Time.now.in_time_zone(timezone.active_support_time_zone))
			
			if @checktime > Time.now.in_time_zone(timezone.active_support_time_zone)
				flash[:notice] = ["You must fix the following errors to continue."]
				flash[:notice] << "Invalid time. Time cannot be in the future. Please recreate your report."
				@newreport.destroy
				redirect_to(:action => 'report')
				return
			end
			@newreport.save
			logger.debug(timezone.zone)
			redirect_to(:action => 'index')
		else
			render :action => 'report'
		end
	end
	
	def show
		@overflow = true
		@reports = Report.order('time DESC').all
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
			redirect_to(:action => 'register')
			return
		end
		
		
		if @user.save
			UserMailer.registration_confirmation(@user).deliver
			flash[:notice] = ["Please check your email to confirm your registration."]
			redirect_to(:action => 'register')
		else
		render('register')
		end
	end
	
	def vote
		flash[:notice] = ["Vote Received!"]
		
		@report = Report.find(params[:data][0])
		@rating = @report.rating.to_i
		@newrating = @rating + (params[:data][1]).to_i
		@report.rating = @newrating
		@report.save
		
		@vote = Vote.new()
		@vote.username = current_user.username
		@vote.report_id = params[:data][0]
		@vote.save
		
		@user = User.find_by_username(@report.username)
		@user.votecount = @user.votecount.to_i + 1
		
		if params[:data[1]].to_i == 0
			
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
		else
			
			if @user.votecount.to_i.between?(0, 6)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.1)
			elsif @user.votecount.to_i.between?(5, 11)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.08)
			elsif @user.votecount.to_i.between?(9, 21)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.05)
			elsif @user.votecount.to_i.between?(19, 41)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.03)
			elsif @user.votecount.to_i.between?(39, 81)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.02)
			else
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.01)
			end
		end
		
		
		@user.save
		
		redirect_to(:action => 'show')
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
		
		def report_params
			
			params.require(:report).permit(:username, :trainnumber, :loconumber, :locotype, :railroad, :location, :direction, :additional, :info, :lat, :lon, :time, :user_id)
			
		end
		
end
