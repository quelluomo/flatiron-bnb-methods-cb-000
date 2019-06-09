class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates_presence_of :checkin, :checkout
  validate :guest_and_host_not_same_user, :checkin_before_checkout, :availability

  def duration
    (checkout - checkin).to_i
  end

  def total_price
    duration * listing.price
  end

  private
  def guest_no_host
    if guest_id == listing.host_id
      errors.add(:guest_id, "You cannot make a reservation on your own listing.")
    end
  end


  def checkin_before_checkout
    if check_out && check_in && check_out <= check_in
     errors.add(:guest_id, "Your check-in date must be before your check-out.")
   end
 end

 def availability
  if (!checkin.nil? && !checkout.nil?)
    listing.reservations.each do |res|
      if (checkin <= res.checkout) && (checkout >= res.checkin)
        errors.add(:checkin, "There is no availability for your dates")
        end
      end
    end
  end
end
