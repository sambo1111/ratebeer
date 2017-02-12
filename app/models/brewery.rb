class Brewery < ActiveRecord::Base

	include MyFunctions

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	validates :name, length: {minimum: 1}
	validate :founded_cant_be_in_future

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

	def getname
		self.name
	end
end
