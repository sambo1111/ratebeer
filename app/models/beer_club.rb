class BeerClub < ActiveRecord::Base

  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def to_s
    "#{name}"
  end

  def unconfirmed_members
    unconfirmed_memberships = memberships.where(confirmed:false)
    unconfirmed_members_list = []
    unconfirmed_memberships.each{|m| unconfirmed_members_list.push(m.user)}

    unconfirmed_members_list
  end

  def confirmed_members
    confirmed_memberships = memberships.where(confirmed:true)
    confirmed_members_list = []
    confirmed_memberships.each{|m| confirmed_members_list.push(m.user)}

    confirmed_members_list
  end

end
