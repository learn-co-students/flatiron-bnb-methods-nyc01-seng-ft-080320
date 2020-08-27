class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  validate :is_valid_listing?

  after_create :set_user_as_host
  before_destroy :reset_user_as_host

  def available?(start_date, end_date)
    !self.reservations.any? do |reservation|
      reservation.overlap?(start_date, end_date)
    end
  end

  def reservations_count
    self.reservations ? self.reservations.count : 0
  end

  def average_review_rating
    self.reviews.reduce(0.0) do |sum, review|
      sum + review.rating
    end/self.reviews.count
  end

  private
  def is_valid_listing?
    if !self.address
      errors.add(:address, "can't be blank")
    end
    if !self.listing_type
      errors.add(:listing_type, "can't be blank")
    end
    if !self.title
      errors.add(:title, "can't be blank")
    end
    if !self.description
      errors.add(:description, "can't be blank")
    end
    if !self.price
      errors.add(:price, "can't be blank")
    end
    if !self.neighborhood
      errors.add(:neighborhood, "can't be blank")
    end
  end

  def set_user_as_host
    if !self.host.host
      self.host.update(host: true)
    end
  end

  def reset_user_as_host
    if self.host.listings.count <= 1
      self.host.update(host: false)
    end
  end
end
