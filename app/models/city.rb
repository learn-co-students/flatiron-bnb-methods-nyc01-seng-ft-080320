class City < ActiveRecord::Base
  include Location::InstanceHelper
  extend Location::ClassHelper

  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings (start_date, end_date)
    _openings(start_date, end_date)
  end

  # def reservations_total
  #   self.listings.reduce(0) do |count, listing|
  #     count + listing.reservations_count
  #   end
  # end

  # def ratio_res_to_listings
  #   self.listings.reduce do |listing_a, listing_b|
  #     listing_a.reservations_count > listing_b.reservations_count ? listing_a : listing_b
  #   end.reservations_count
  # end

  # def self.highest_ratio_res_to_listings
  #   self.all.reduce do |city1, city2|
  #     city1.ratio_res_to_listings > city2.ratio_res_to_listings ? city1 : city2
  #   end
  # end

  # def self.most_res
  #   self.all.reduce do |city1, city2|
  #     city1.reservations_total > city2.reservations_total ? city1 : city2
  #   end
  # end
end

