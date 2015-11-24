class Report < ActiveRecord::Base
	belongs_to :user
	
	STATE_LIST = ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI',
		'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS',
		'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR',
		'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY']
		
	RAILROAD_LIST = ['Amtrak', 'BNSF', 'Caltrain', 
		'Canadian National', 'Canadian Pacific', 'CSX', 'Coaster', 
		'Conrail Shared Assets', 'Florida East Coast', 'Kansas City Southern',
		'Long Island Rail Road', 'MARC', 'MBTA', 'Metra', 
		'Metro-North Commuter Railroad', 'Metrolink',
		'New England Central Railroad', 'NJ Transit', 'Norfolk Southern',
		'Northstar', 'Pan Am Railways', 'Providence & Worcester', 
		'SEPTA', 'SunRail', 'Trinity Railway Express', 'Tri-Rail',
		'Union Pacific', 'Virginia Railway Express', 'Other']
		
	DIRECTIONS = ['North', 'South', 'East', 'West']
	
	geocoded_by :location
	after_validation :geocode
	
	validates :trainnumber, presence: {in: [true], message: "You must enter a train number."}, numericality: {in: [true], message: "The train number field must be a numerical value."}, length: {maximum: 5, message: "The train number cannot be more than 5 digits."}
	validates :loconumber, presence: {in: [true], message: "You must enter a locomotive number."}, numericality: {in: [true], message: "The locomotive number field must be a numerical value."}, length: {maximum: 5, message: "The locomotive number cannot be more than 5 digits."}
	validates :locotype, presence: {in: [true], message: "You must enter a locomotive type"}

	
end
