class Style < ActiveRecord::Base

  include MyFunctions

  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    self.name
  end

  def self.top(n)
		sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.average_rating||0) }
		top_n = sorted_by_rating_in_desc_order[0,n]
	end
end
