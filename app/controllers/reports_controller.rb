class ReportsController < ApplicationController
protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
	def index
		@overflow = false
		@reports = Report.where(:created_at => (1.week.ago..Time.zone.now))
		build_markers
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
			logger.debug(@report.errors.full_messages)
			redirect_to(:action => 'new')
			return
		else
			if params[:manuallocation]
				city_state_prov = "#{@report.location.city}, #{@report.location.state_prov}"
				@report.location.latitude = Geocoder.coordinates(city_state_prov)[0]
				@report.location.longitude = Geocoder.coordinates(city_state_prov)[1]
			else
				address = Geocoder.address(@report.location.latitude.to_s + ", " + @report.location.longitude.to_s)
				address_split = address.split(",")
				if address_split.length == 2
					@report.location.city = address_split[0]
					@report.location.state_prov = address_split[1]
				else
					@report.location.city = address_split[1]
					@report.location.state_prov = address_split[2][0..2]
				end
			end

			if @report.location.has_matches?
				@report.location.adjust_location
			end


			@report.info = full_sanitizer.sanitize(@report.info)

			if params[:railroadsuggestion]
			File.open("railroadsuggestions.txt", "a") { |file| file.write params[:report][:railroad] + " " + params[:report][:railroad2] + " " + params[:report][:railroad3] + " " + params[:report][:railroad4] + " " + params[:report][:railroad5] + " " + params[:report][:railroad6]}
		end
		end
		if @report.save
		   @timezone = @report.set_timezone
		   if @timezone == false
			   	flash[:notice] = ["You must fix the following errors to continue."]
				flash[:notice] << "Location invalid. We only support reporting within the United States and Canada at this time."
				@report.location.destroy
				@report.locomotives.destroy_all
				@report.destroy
				redirect_to(:action => 'new')
				return
		   end

		   @report.set_offset(@timezone)

		   if !@report.valid_time?(Time.new(params[:report]["time(1i)"].to_i,params[:report]["time(2i)"].to_i,params[:report]["time(3i)"].to_i,params[:report]["time(4i)"].to_i,params[:report]["time(5i)"].to_i, 0, @offset), @timezone)
		   		flash[:notice] = ["You must fix the following errors to continue."]
				flash[:notice] << "Invalid time. Time cannot be in the future."
				@report.location.destroy
				@report.locomotives.destroy_all
				@report.destroy
				redirect_to(:action => 'new')
				return
		   end

		   if @report.is_duplicate?
		   		flash[:notice] = ["You must fix the following errors to continue."]
				flash[:notice] << "This train has already been reported by a user."
				@report.location.destroy
				@report.locomotives.destroy_all
				@report.destroy
				redirect_to(:action => 'new')
				return
		   end

			@report.save
			redirect_to(:action => 'index')
		else
			redirect_to(:action => 'new')
		end
	end
	
	def update
		@report = Report.find(params[:report][:id])

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
				logger.debug(params[:report][:city])
				logger.debug(params[:report][:state_prov])
				location = params[:report][:city] + ", " + params[:state_prov]
				@report.location.latitude = Geocoder.coordinates(location)[0]
				@report.location.longitude = Geocoder.coordinates(location)[1]
				@report.location.city = params[:report][:city]
				@report.location.state_prov = params[:state_prov]
			else
				@report.location.latitude = params[:report][:latitude]
				@report.location.longitude = params[:report][:longitude]
				address = Geocoder.address(@report.location.latitude.to_s + ", " + @report.location.longitude.to_s)
				address_split = address.split(",")
				if address_split.length == 2
					@report.location.city = address_split[0]
					@report.location.state_prov = address_split[1]
				else
					@report.location.city = address_split[1]
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
		end	
		if @report.save
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
		@report.location.destroy
		@report.locomotives.destroy_all
		@report.destroy
		redirect_to(:viewreports)
	end
	
	private
		
		def report_params
			params.require(:report).permit(:username, :railroad, :train_number, :direction, :info, :time, :user_id, :rating, :timezone, :offset, location: [ :latitude, :longitude, :city, :state_prov, :id ], locomotives: [ :id, :number, :loco_type, :railroad ])
		end

		def build_markers
			@hash = Gmaps4rails.build_markers(@reports) do |report, marker|
			  locomotives = report.locomotives
			  offset = report.offset
			  marker.lat report.location.latitude
			  marker.lng report.location.longitude
			  marker.infowindow info_window_html(report, locomotives, offset)
				
			  marker.picture({
			  	:url => ActionController::Base.helpers.image_path('marker.png', type: :image),
			  	:width => 15,
				:height => 20
			  })
			end
		end

		def locomotives_to_html(locomotives)
			html_locos = ""
			  for x in 0..locomotives.length - 1
				if x == 0
					locomotive_attr = "#{locomotives[x].loco_type}: #{locomotives[x].number}"
					html_locos = locomotive_attr
				else
					locomotive_attr = "#{locomotives[x].loco_type}: #{locomotives[x].number}"
					html_locos = html_locos + ", " + locomotive_attr
				end
				
			  end
			  html_locos
		end

		def info_window_html(report, locomotives, offset)
			"<div class='infoboxheader'>" + report.train_number + "</div>" + "<ul class='infobox'>" + 
			"<li>" +
				"<label>Posted By:</label>" +
				"<span>" + report.username + "</span>" +
			"</li>" + 
			"<li>" +
				"<label>Locomotives:</label>" +
				"<span>" + locomotives_to_html(locomotives) + "</span>" +
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
				"<span>" + report.time.in_time_zone(offset.to_i).strftime("%m/%d/%Y - %H:%M") + "</span>" +
			"</li>" + 
			"<li>" +
				"<label>Additional Info:</label>" +
				"<span>" + report.info + "</span>" +
			"</li>" + 
			
			"</ul>"
		end
		
end
