class City < ActiveRecord::Base
  include Helpers::InstanceMethods
  extend Helpers::ClassMethods

  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings

  include Helpers

  def city_openings(start_date, end_date)
    openings(start_date, end_date)
  end


end
