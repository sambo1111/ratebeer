class User < ActiveRecord::Base

  include MyFunctions

  has_secure_password

  validates :username, uniqueness: true, length: {minimum: 3, maximum: 30}
  validates :password, length: {minimum: 4}, format: {with: /\^([a-zA-Z]*[A-Z]+\d+)|(\d+[A-Z]+[a-zA-Z]*)|([A-Z]+[a-zA-Z]*\d+)/}

  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_brewery
    favorite_from_collection(self.ratings.group_by{|rat| rat.beer.brewery})
  end

  def favorite_style
    favorite_from_collection(self.ratings.group_by{|rat| rat.beer.style.name})
  end

  def favorite_from_collection(ratings)
    r = ratings

    highest = 0;
    fav = "no favorite"
    r.map do |k, v|
      styles_average = average_for_collection(r[k])
      if styles_average > highest
        highest = styles_average
        fav = k
      end
    end

    fav
  end

  def average_for_collection(r)
    sum = 0;
    r.each do |e|
      sum = sum + e.score
    end
    sum = sum / r.count
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |u| -(u.ratings.count||0) }
		top_n = sorted_by_rating_in_desc_order[0,n]
  end

  def is_member_of?(beer_club)
    beer_clubs.include? beer_club
  end
end
