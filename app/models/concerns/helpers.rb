module Helpers
  module InstanceMethods

  def openings(start_date, end_date)
    openings = []
      self.listings.each do |listing|
        if listing.reservations.none? { |r|
          (start_date.to_date >= r.checkin && start_date.to_date <= r.checkout) || (end_date.to_date <= r.checkout && end_date.to_date >= r.checkin)}
        openings << listing
      end
    end
      openings
    end
  end

  def ratio_reservations_to_listings
    if listings.count > 0
      reservations.count.to_f / listings.count.to_f
    end
  end

  module ClassMethods

    def highest_ratio_reservations_to_listings
      all.max do |a, b|
        a.ratio_reservations_to_listings <=> b.ratio_reservations_to_listings
      end
    end

    def most_reservations
      all.max do |a, b|
        a.reservations.count <=> b.reservations.count
      end
    end
  end
end
