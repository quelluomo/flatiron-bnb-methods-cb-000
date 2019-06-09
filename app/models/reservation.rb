class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates_presence_of :checkin, :checkout
  validate :guest_not_host, :chkin_b4_chkout, :availability

  def duration
    (checkout - checkin).to_i
  end

  def total_price
    duration * listing.price
  end

  private
  def guest_no_host
    if guest_id == listing.host_id
      errors.add(:guest_id, "Guest neva host.")
    end
  end


  def chkin_b4_chkout
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
