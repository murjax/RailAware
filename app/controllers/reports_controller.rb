class ReportsController < ApplicationController
protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
	def index
		@overflow = false
		@reports = Report.where(:created_at => (1.week.ago..Time.zone.now))
		
		@hash = Gmaps4rails.build_markers(@reports) do |report, marker|
		  @locomotivesList = report.locomotives
		  @htmlLocos = "";
		  for x in 0..@locomotivesList.length - 1
			if x == 0
				locomotive_attr = "#{@locomotivesList[x].loco_type}: #{@locomotivesList[x].number}"
				@htmlLocos = locomotive_attr
			else
				locomotive_attr = "#{@locomotivesList[x].loco_type}: #{@locomotivesList[x].number}"
				@htmlLocos = @htmlLocos + ", " + locomotive_attr
			end
			
		  end
		  @offset = report.offset
		  @reporttime = Time.new(report.time.year, report.time.month, report.time.day, report.time.hour, report.time.min, report.time.sec, @offset)
		  marker.lat report.location.latitude
		  marker.lng report.location.longitude
		  marker.infowindow "<div class='infoboxheader'>" + report.train_number + "</div>" + "<ul class='infobox'>" + 
			"<li>" +
				"<label>Posted By:</label>" +
				"<span>" + report.username + "</span>" +
			"</li>" + 
			"<li>" +
				"<label>Locomotives:</label>" +
				"<span>" + @htmlLocos + "</span>" +
			"</li>" + 
			"<li>" +
				"<label>Location:</label>" +
				"<span>" + "#{report.location.city}, #{report.location.state_prov}" + "</span>" +
			"</li>" + 
			"<li>" +
				"<label>Direction:</label>" +
				"<span>" + report.direction + "</span>" +
			"</li>" + 
			"<li>" +
				"<label>Date/Time Seen:</label>" +
				"<span>" + report.time.in_time_zone(@offset.to_i).strftime("%m/%d/%Y - %H:%M") + "</span>" +
			"</li>" + 
			"<li>" +
				"<label>Additional Info:</label>" +
				"<span>" + report.info + "</span>" +
			"</li>" + 
			
			"</ul>"
			
			marker.picture({
				:url => ActionController::Base.helpers.image_path('marker.png', type: :image),
				:width => 15,
				:height => 20
			})
		end
	end
	
	def new
		@report = Report.new
		@report.locomotives.build
		@report.build_location
		@overflow = true
		
		if !current_user
			redirect_to(:login)
		end
	end
	
	def edit
		@oldreport = Report.find(params[:id])
		@overflow = true
		
		
		if !current_user
			redirect_to(:login)
		end
		
		if @oldreport.username != current_user.username
			if current_user.rating.to_i < 95
				redirect_to(:viewreports)
			end
		end
		
		if !(DateTime.now.beginning_of_day..DateTime.now.end_of_day).cover? @oldreport.time
			redirect_to(:viewreports)
		end
	end
	
	def create
		full_sanitizer = Rails::Html::FullSanitizer.new
		parameters = report_params.except!("location")
		parameters = parameters.except!("locomotives")
		locomotives = []
		locomotives.push(report_params.delete("locomotives"))
		location = Location.new(report_params.delete("location"))
		@report = Report.new(parameters)
		@report.location = location
		@report.locomotives = locomotives.map{ |l| Locomotive.new(l) }

		if !@report.valid?
			flash[:notice] = ["You must fix the following errors to continue."]
			@report.errors.each do |attribute, message|
				flash[:notice] << message
			end

			session[:report] = params[:report]
			if params[:railroad] == "Other"
				session[:railroad] = params[:report][:railroad]
			else
				session[:railroad] = params[:railroad]
			end
			session[:direction] = params[:direction]
			session[:state] = params[:state]
			session[:province] = params[:province]
			session[:country] = params[:country]
			logger.debug(@report.errors.full_messages)
			redirect_to(:action => 'new')
			return
		else
			if params[:manuallocation]
				location = @report.location.city + ", " + @report.location.state_prov
				@report.latitude = Geocoder.coordinates(@report.location)[0]
				@report.longitude = Geocoder.coordinates(@report.location)[1]
			else
				address = Geocoder.address(@report.location.latitude.to_s + ", " + @report.location.longitude.to_s)
				address_split = address.split(",")
				if address_split.length == 2
					@report.location.city = address_split[0]
					@report.location.state_prov = address_split[1]
				else
					@report.location.city = address_split[0]
					@report.location.state_prov = address_split[2][0..2]
				end
			end

			allreports = Report.where(:created_at => (1.week.ago..Time.zone.now))
			if !allreports.empty?
				locmatches = true;
				while locmatches == true do
					allreports.each do |xreport|
						if (@report.location.latitude.to_f.round(4).equal? xreport.location.latitude) && (@report.location.longitude.to_f.round(4).equal? xreport.location.longitude)
							@report.location.latitude = @report.location.latitude - 0.0001
							@report.location.longitude = @report.location.longitude - 0.0001
						else
							locmatches = false
						end	
					end
				end
			end

			@report.info = full_sanitizer.sanitize(@report.info)

			if params[:railroadsuggestion]
			File.open("railroadsuggestions.txt", "a") { |file| file.write params[:report][:railroad] + " " + params[:report][:railroad2] + " " + params[:report][:railroad3] + " " + params[:report][:railroad4] + " " + params[:report][:railroad5] + " " + params[:report][:railroad6]}
		end
		end
		if @report.save
			timezone = Timezone::Zone.new :latlon => [@report.location.latitude, @report.location.longitude]
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
			@report.offset = @offset
			logger.debug(params[:report])
			@checktime = Time.new(params[:report]["time(1i)"].to_i,params[:report]["time(2i)"].to_i,params[:report]["time(3i)"].to_i,params[:report]["time(4i)"].to_i,params[:report]["time(5i)"].to_i, 0, @offset)
			if @checktime > Time.now.in_time_zone(timezone.active_support_time_zone)
				flash[:notice] = ["You must fix the following errors to continue."]
				flash[:notice] << "Invalid time. Time cannot be in the future."
				@report.destroy
				redirect_to(:action => 'report')
				return
			end
			
			@duplicatetimecheck = Report.where(created_at: 1.hours.ago..Time.now)
			if @duplicatetimecheck.length > 1
				@duplicatetimecheck.each do |r|
					if r.location.latitude == @report.location.latitude
						@duplicatelocationcheck.push(r)
					end
				end
				if @duplicatelocationcheck.length > 1
					@duplicatetraincheck = @duplicatelocationcheck.where(train_number: @report.train_number)
					if @duplicatetraincheck.length > 1
						flash[:notice] = ["You must fix the following errors to continue."]
						flash[:notice] << "This train has already been reported by a user."
						@report.destroy
						redirect_to(:action => 'report')
						return
					end
				end
			end
			@report.save
			logger.debug(timezone.zone)
			redirect_to(:action => 'index')
		else
			redirect_to(:action => 'new')
		end
	end
	
	def update
		@report = Report.find(params[:id])

		if !@report.valid?
			flash[:notice] = ["You must fix the following errors to continue."]
			@report.errors.each do |attribute, message|
				flash[:notice] << message
			end

			session[:report] = params[:report]
			if params[:railroad] == "Other"
				session[:railroad] = params[:report][:railroad]
			else
				session[:railroad] = params[:railroad]
			end
			session[:direction] = params[:direction]
			session[:state] = params[:state]
			session[:province] = params[:province]
			session[:country] = params[:country]
			redirect_to(:action => 'report')
		else
			if params[:manuallocation]
				location = @report.location.city + ", " + @report.location.state_prov
				@report.latitude = Geocoder.coordinates(@report.location)[0]
				@report.longitude = Geocoder.coordinates(@report.location)[1]
			else
				address = Geocoder.address(@report.location.latitude.to_s + ", " + @report.location.longitude.to_s)
				address_split = address.split(",")
				if @address_split.length == 2
					@report.location.city = address_split[0]
					@report.location.state_prov = address_split[1]
				else
					@report.location.city = address_split[0]
					@report.location.state_prov = address_split[2][0..2]
				end
			end

			allreports = Report.where(:created_at => (1.week.ago..Time.zone.now))
			if !allreports.empty?
				locmatches = true;
				while locmatches == true do
					allreports.each do |xreport|
						if (@report.location.latitude.round(4).equal? xreport.location.latitude) && (@report.location.longitude.round(4).equal? xreport.location.longitude)
							@report.location.latitude = @report.location.latitude - 0.0001
							@report.location.longitude = @report.location.longitude - 0.0001
						else
							locmatches = false
						end	
					end
				end
			end
		end	
		if @report.update_attributes(user_params)
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
	
	def delete
		@report = Report.find(params[:id])
		@overflow = true
		
		if !current_user
			redirect_to(:login)
			return
		end
		
		if @report.username != current_user.username
			redirect_to(:viewreports)
			return
		end
		
		if !(DateTime.now.beginning_of_day..DateTime.now.end_of_day).cover? @report.time
			redirect_to(:viewreports)
			return
		end
		
		@report.destroy
		redirect_to(:viewreports)
	end
	
	private
		
		def report_params
			params.require(:report).permit(:username, :railroad, :train_number, :direction, :info, :time, :user_id, :rating, :timezone, :offset, location: [ :latitude, :longitude, :city, :state_prov, :id ], locomotives: [ :id, :number, :loco_type, :railroad ])
		end
		
end
