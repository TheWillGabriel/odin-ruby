class Airport < ApplicationRecord
  has_many :departing_flights, class_name: 'Flight', foreign_key: 'from_id',
                               dependent: :destroy
  has_many :arriving_flights, class_name: 'Flight', foreign_key: 'to_id',
                              dependent: :destroy
end
