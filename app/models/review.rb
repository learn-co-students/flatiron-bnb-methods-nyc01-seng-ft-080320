class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validate :is_valid_review?


  private
  def is_valid_review?
    #byebug
    if !self.rating
      #byebug
      errors.add(:rating, "cannot be empty")
    end
    if !self.description
      #byebug
      errors.add(:description, "cannot be null")
    end
    if !self.reservation
      #byebug
      errors.add(:reservation,"cannot be null")
    end
    if self.reservation && self.reservation.status != "accepted"
      #byebug
      errors.add(:reservation, "should be accepted first")
    end
    if self.reservation && self.reservation.checkout > Date.today
      #byebug
      errors.add(:reservation, "should have passed")
    end
  end
end
