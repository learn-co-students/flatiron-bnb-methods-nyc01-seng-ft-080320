class Neighborhood < ActiveRecord::Base
  include Location::InstanceHelper
  extend Location::ClassHelper

  belongs_to :city
  has_many :listings

  def neighborhood_openings (start_date, end_date)
    _openings(start_date, end_date)
  end
end
