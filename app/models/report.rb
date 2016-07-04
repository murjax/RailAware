class Report < ActiveRecord::Base
	belongs_to :user
	has_many :locomotives
	has_one :location
	accepts_nested_attributes_for :locomotives, allow_destroy: true
	accepts_nested_attributes_for :location, allow_destroy: true
	
	STATE_LIST = ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI',
		'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS',
		'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR',
		'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY']
		
	PROVINCE_LIST = ['AB', 'BC', 'MB', 'NB', 'NL', 'NT', 'NS', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT']
		
	RAILROAD_LIST = ['Amtrak (AMTK)', 'BNSF', 'Caltrain (JPBX)', 
		'Canadian National (CN)', 'Canadian Pacific (CP)', 'CSX (CSXT)', 'Coaster (SDNX)', 
		'Conrail Shared Assets (CRCX)', 'Florida East Coast (FEC)', 'Kansas City Southern (KCS)',
		'Long Island Rail Road (LIRR)', 'MARC', 'MBTA (MBTX)', 'Metra (METX)', 
		'Metro-North Commuter Railroad (MNCW)', 'Metrolink (SCAX)',
		'New England Central Railroad (NECR)', 'NJ Transit (NJTR)', 'Norfolk Southern (NS)',
		'Northstar (MNRX)', 'Pan Am Railways (BM, MEC, ST)', 'Providence & Worcester (PW)', 
		'SEPTA (SPAX)', 'SunRail (CFR)', 'Trinity Railway Express (TRE)', 'Tri-Rail (TRCX)',
		'Union Pacific (UP)', 'Virginia Railway Express (VREX)', 'Other']
		
	DIRECTIONS = ['North', 'South', 'East', 'West']
	
	#geocoded_by :location
	#reverse_geocoded_by :latitude, :longitude do |obj, results|
	#	if geo = results.first
	#		obj.location = geo.city + ", " + geo.state_code
	#	end
	#end
	#after_validation :reverse_geocode
	validates :train_number, presence: {in: [true], message: "You must enter a train number."}
	#validates :loconumber, presence: {in: [true], message: "You must enter a locomotive number."}, numericality: {in: [true], message: "The locomotive number field must be a numerical value."}, length: {maximum: 5, message: "The locomotive number cannot be more than 5 digits."}
	#validates :locotype, presence: {in: [true], message: "You must enter a locomotive type"}
	validates :info, length: {maximum: 200, message: "Text must be within 200 characters."}

	def set_timezone
		timezone = Timezone::Zone.new :latlon => [self.location.latitude, self.location.longitude]
		if timezone.zone == "America/St_Johns"
			self.timezone = "NT"
			timezone
		elsif timezone.zone == "America/Moncton" || timezone.zone == "America/Blanc-Sablon" || timezone.zone == "America/Glace_Bay"
			self.timezone = "AT"
			timezone
		elsif timezone.zone == "America/New_York" || timezone.zone == "America/Toronto" || timezone.zone == "America/Detroit" || timezone.zone == "America/Fort_Wayne" || timezone.zone == "America/Indiana/Indianapolis" || timezone.zone == "America/Indiana/Marengo" || timezone.zone == "America/Indiana/Petersburg" || timezone.zone == "America/Indiana/Vevay" || timezone.zone == "America/Indiana/Winamac" || timezone.zone == "America/Indianapolis" || timezone.zone == "America/Kentucky/Louisville" || timezone.zone == "America/Kentucky/Monticello" || timezone.zone == "America/Louisville" || timezone.zone == "America/Atikokan" || timezone.zone == "America/Iqaluit" || timezone.zone == "America/Nipigon" || timezone.zone == "America/Thunder_Bay"
			self.timezone = "ET"
			timezone
		elsif timezone.zone == "America/Chicago" || timezone.zone == "America/Winnipeg" || timezone.zone == "America/Regina" || timezone.zone == "America/Indiana/Knox" || timezone.zone == "America/Indiana/Tell_City" || timezone.zone == "America/Indiana/Vincennes" || timezone.zone == "America/Knox_IN" || timezone.zone == "America/North_Dakota/Beulah" || timezone.zone == "America/North_Dakota/New_Salem" || timezone.zone == "America/North_Dakota/Center" || timezone.zone == "America/Inuvik" || timezone.zone == "America/Rainy_River" || timezone.zone == "America/Rankin_Inlet" || timezone.zone == "America/Resolute" || timezone.zone == "America/Swift_Current"
			self.timezone = "CT"
			timezone
		elsif timezone.zone == "America/Denver" || timezone.zone == "America/Phoenix" || timezone.zone == "America/Edmonton" || timezone.zone == "America/Shiprock" || timezone.zone == "America/Boise"
			self.timezone = "MT"
			timezone
		elsif timezone.zone == "America/Los_Angeles" || timezone.zone == "America/Vancouver" || timezone.zone == "America/Creston" || timezone.zone == "America/Dawson" || timezone.zone == "America/Dawson_Creek" || timezone.zone == "America/Fort_Nelson" || timezone.zone == "America/Cambridge_Bay" || timezone.zone == "America/Whitehorse"
			self.timezone = "PT"
			timezone
		elsif timezone.zone == "America/Anchorage" || timezone.zone == "America/Juneau" || timezone.zone == "America/Nome" || timezone.zone == "America/Adak" || timezone.zone == "America/Atka" || timezone.zone == "America/Sitka"
			self.timezone = "AKT"
			timezone
		elsif timezone.zone == "Pacific/Honolulu"
			self.timezone = "HT"
			timezone
		else
			false
		end
	end

	def set_offset(timezone)
		absolute_offset = timezone.utc_offset.to_i.abs
		offset = Time.at(absolute_offset).utc.strftime("-%H:%M")
		offset = offset.to_s
		self.offset = offset
	end

	def valid_time?(time, timezone)
		if time > Time.now.in_time_zone(timezone.active_support_time_zone)
			false
		else
			true
		end
	end

	def is_duplicate?
		duplicate_times = Location.where(created_at: 1.hours.ago..Time.now)
		if duplicate_times.length > 1
			duplicate_locations = duplicate_times.where(latitude: self.location.latitude)
			if duplicate_locations.length > 1
				duplicate_report_ids = []
				duplicate_locations.select("report_id").each {|i| duplicate_report_ids.push(i.report_id)}
				duplicate_location_reports = Report.where(id: duplicate_report_ids)
				duplicate_trains = duplicate_location_reports.where(train_number: self.train_number)
				if duplicate_trains.length > 1
					true
				else
					false
				end
			else
				false
			end
		else
			false
		end
	end
end
