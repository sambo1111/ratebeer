class Beer < ActiveRecord::Base

	include MyFunctions

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	#def average_rating
	#	sum = 0
	#	ratings.each do |r|
	#		sum = sum + r.score
	#	end
	#	sum = sum / ratings.count
	#	"Has #{ratings.count} ratings, average #{sum}"
	#end

	def to_s
		"#{name}, #{brewery.name}"
	end
end
