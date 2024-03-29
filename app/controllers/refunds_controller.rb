class RefundsController < ApplicationController
  before_action :set_refund_with_parents, only: %i[edit update refund_acceptance]

  def new
    @refund = Refund.new
  end

  def edit
    @refund = Refund.find(params[:id])
    booking = @refund.booking
    booking.no_of_tickets
    @workshop = booking.workshop
    @workshop_name = @workshop.name
    @total_tickets = booking.no_of_tickets
    @amount_paid = booking.amount_paid
    @booking_date = booking.created_at.strftime('%d %a %B, %Y')
  end

  def create
    booking = Booking.find_by(order_number: params[:refund][:order_number])
    if booking.present?
      if booking.refundable?
        @refund = Refund.create(
          customer_id: booking.customer_id,
          booking_id: booking.id,
          state: 'accepted'
        )
        redirect_to edit_refund_path(@refund), notice: 'Your booking request
        valid. Please fill other details to process your refund request.'
      else
        redirect_to new_refund_path, alert: "You are requesting refund for a past workshop.
        Refunds are only allowed for workshop which are to be taken in the future."
      end
    else
      redirect_to new_refund_path, alert: "You provided an invalid booking ID 
      #{params[:refund][:order_number]}. We found no booking with this booking id.
      Please provide valid booking ID."
    end
  end

  def update
    refundable_amount = params[:refund][:no_of_tickets].to_i * @workshop.registration_fee
    if @refund.update(no_of_tickets: params[:refund][:no_of_tickets])
      RefundNotificationMailer.customer_refund_notification(@refund).deliver_now
      RefundNotificationMailer.admin_refund_notification(@refund).deliver_now
      redirect_to refund_acceptance_refund_path, notice: "You are eligible for refund of #{refundable_amount.to_f}"
    else
      redirect_to refund_acceptance_refund_path, alert: 'Some thing went wrong'
    end
  rescue StandardError => e
    redirect_to refund_acceptance_refund_path, alert: e.message
  end

  def refund_acceptance
  end

  private

  def set_refund_with_parents
    @refund = Refund.find(params[:id])
    booking = @refund.booking
    booking.no_of_tickets
    @workshop = booking.workshop
    @workshop_name = @workshop.name
    @total_tickets = booking.no_of_tickets
    @amount_paid = booking.amount_paid
    @booking_date = booking.created_at.strftime('%d %a %B, %Y')
  end
end