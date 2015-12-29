class Report < ActiveRecord::Base
	belongs_to :user
	
	STATE_LIST = ['AL', 'AB', 'AK', 'AZ', 'AR', 'BC', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI',
		'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MB', 'MD', 'MA', 'MI', 'MN', 'MS',
		'MO', 'MT', 'NE', 'NV', 'NB', 'NH', 'NJ', 'NM', 'NY', 'NL', 'NC', 'ND', 'NT', 'NS', 'NU', 'OH', 'OK', 'ON', 'OR',
		'PA', 'PE', 'QC', 'RI', 'SK', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY', 'YT']
		
	RAILROAD_LIST = ['Amtrak (AMTK)', 'Burlington Northern Santa Fe (BNSF)', 'Caltrain (JPBX)', 
		'Canadian National (CN)', 'Canadian Pacific (CP)', 'CSX (CSXT)', 'Coaster (SDNX)', 
		'Conrail Shared Assets (CRCX)', 'Florida East Coast (FEC)', 'Kansas City Southern (KCS)',
		'Long Island Rail Road (LIRR)', 'MARC', 'MBTA (MBTX)', 'Metra (METX)', 
		'Metro-North Commuter Railroad (MNCW)', 'Metrolink (SCAX)',
		'New England Central Railroad (NECR)', 'NJ Transit (NJTR)', 'Norfolk Southern (NS)',
		'Northstar (MNRX)', 'Pan Am Railways (BM, MEC, PTM, ST)', 'Providence & Worcester (PW)', 
		'SEPTA (SEPA)', 'SunRail', 'Trinity Railway Express (TRE)', 'Tri-Rail (TRCX)',
		'Union Pacific (UP)', 'Virginia Railway Express (VREX)', 'Other']
		
	DIRECTIONS = ['North', 'South', 'East', 'West']
	
	geocoded_by :location
	after_validation :geocode
	
	validates :trainnumber, presence: {in: [true], message: "You must enter a train number."}, length: {maximum: 8, message: "The train number cannot be more than 8 characters."}
	validates :loconumber, presence: {in: [true], message: "You must enter a locomotive number."}, numericality: {in: [true], message: "The locomotive number field must be a numerical value."}, length: {maximum: 5, message: "The locomotive number cannot be more than 5 digits."}
	validates :locotype, presence: {in: [true], message: "You must enter a locomotive type"}

	
end
