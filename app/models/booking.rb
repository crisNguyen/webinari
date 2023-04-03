class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :workshop
  has_many :refunds

  validates :order_number, presence: true, uniqueness: true

  before_validation :generate_order_number
  after_create :update_workshop_sit_count

  def refundable?
    workshop.start_date > Date.today
  end

  private

  def update_workshop_sit_count
    workshop.update(remaining_sits: workshop.remaining_sits - no_of_tickets)
  end

  def generate_order_number
    self.order_number = "BOOKING-#{SecureRandom.hex(5).upcase}"
  end
end
