class User < ActiveRecord::Base
  #host methods
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :guests, through: :reservations, :foreign_key => 'guest_id'
  has_many :host_reviews, :class_name => "Review", through: :guests, source: "reviews"

  #guest methods
  has_many :trips, :class_name => "Reservation", :foreign_key => 'guest_id'
  has_many :reviews, :foreign_key => 'guest_id'
  has_many :accommodations, through: :trips, :class_name => "Listing", source: "listings"
  has_many :hosts, :class_name => "User", through: :accommodations
  
end
