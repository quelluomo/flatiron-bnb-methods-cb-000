class Neighborhood < ActiveRecord::Base
  include Helpers::InstanceMethods
  extend Helpers::ClassMethods
  belongs_to :city
  has_many :listings
  has_many :reservations, :through => :listings

  include Helpers

  def neighborhood_openings(start_date, end_date)
    openings(start_date, end_date)
  end

end
