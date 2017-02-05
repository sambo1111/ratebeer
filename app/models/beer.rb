class Beer < ActiveRecord::Base

	include MyFunctions

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, through: :ratings, source: :user
	validates :name, length: {minimum: 1}
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

	def average
		return 0 if ratings.empty?
		ratings.map { |r| r.score}.sum / ratings.count.to_f
	end
end
