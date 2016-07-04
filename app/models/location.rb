class Location < ActiveRecord::Base
  belongs_to :report

	def has_matches?
		all_locations = Location.where(:created_at => (1.week.ago..Time.zone.now))

		if !all_locations.empty?
			matches = true

			while matches == true do 
				all_locations.each do |l|
					if !((self.latitude.to_f.round(4).equal? l.latitude) && (self.longitude.to_f.round(4).equal? l.longitude))
						matches = false
					end	
				end
			end
			matches
		end
	end


	def adjust_location
		self.latitude = self.latitude - 0.0001
		self.longitude = self.longitude - 0.0001
	end
end
