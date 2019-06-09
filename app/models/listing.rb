class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood_id, presence: true

  before_save :become_host
  before_destroy :end_host

  def average_review_rating
   ratings = []
   self.reservations.each do |r|
     ratings << r.review.rating
   end
   ratings.sum.to_f / ratings.size
 end

 def become_host
  self.host.update(host: true)
 end

 def end_host
   if self.host.listings.count <= 1
     host.update(host: false)
   end
 end

end
