class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'

  has_many :guests, through: :reservations
  has_many :accommodations, through: :trips, source: :listing
  has_many :host_reviews, { :through => :reservations, :source => :review }
  has_many :hosts, :through => :accommodations

end
