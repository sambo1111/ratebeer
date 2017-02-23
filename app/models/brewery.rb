class Brewery < ActiveRecord::Base

	include MyFunctions

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	validates :name, length: {minimum: 1}
	validate :founded_cant_be_in_future

	scope :active, -> {where active:true}
	scope :retired, -> {where active:[nil, false]}

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def restart
		self.year = 2017
		puts "changed year to #{year}"
	end

	def founded_cant_be_in_future
		 if year < 1042 || year > Date.today.year
			 errors.add(:year, "Invalid year")
		 end
	end

	def self.top(n)
		sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
		top_n = sorted_by_rating_in_desc_order[0,n]
	end

	def to_s
		name
	end

	def getname
		name
	end
end
