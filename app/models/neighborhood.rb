class Neighborhood < ActiveRecord::Base
  include Helpers::InstanceMethods
  extend Helpers::ClassMethods
  belongs_to :city
  has_many :listings

end
