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

end
