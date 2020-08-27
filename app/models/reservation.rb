class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validate :is_valid_reservation?

  def overlap?(start_date, end_date)
    start_date = start_date.class == Date ? start_date : Date.parse(start_date)
    end_date = end_date.class == Date ? end_date : Date.parse(end_date)
    if self.checkin <= end_date && self.checkout >= start_date
      return true
    else
      return false
    end
  end

  def duration
    duration = self.checkout - self.checkin
    duration.to_i
  end

  def total_price
    self.listing.price * self.duration
  end

  private
  def is_valid_reservation?
    if !self.checkin
      errors.add(:checkin, "can't be blank")
    end
    if !self.checkout
      errors.add(:checkout, "can't be blank")
    end
    if (self.checkin && self.checkout) && self.checkout < self.checkin
      errors.add(:checkin, "cannot be before checkin")
    end
    if (self.checkin && self.checkout) && self.checkout == self.checkin
      errors.add(:checkout, "cannot be same as checkin")
    end
    if (self.guest && self.listing && self.listing.host) && self.guest.id == self.listing.host.id
      errors.add(:guest, "You cannot make reservation on your own listing")
    end
    if (self.checkin && self.checkout) && !self.listing.available?(self.checkin, self.checkout)
      errors.add(:guest, "listing is not available during those dates")
    end
  end
end
