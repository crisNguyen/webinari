class BookingsController < ApplicationController
  def create
    @stripe_service = StripeService.new
    @workshop = Workshop.find(params[:workshop_id])
    @customer = Customer.find_by(email: params[:email])
    ActiveRecord::Base.transaction do
      @customer.blank? && @customer = Customer.create(customer_params)
      @stripe_customer = @stripe_service.find_or_create_customer(@customer)
      @card = @stripe_service.create_stripe_customer_card(card_token_params, @stripe_customer)
      @amount_to_be_paid = params[:no_of_tickets].to_i * @workshop.registration_fee
      @charge = @stripe_service.create_stripe_charge(@amount_to_be_paid, @stripe_customer.id, @card.id, @workshop)

      booking = @workshop.bookings.create(
        customer_id: @customer.id,
        stripe_transaction_id: @charge.id,
        no_of_tickets: params[:no_of_tickets].to_i,
        amount_paid: @amount_to_be_paid
      )

      BookingsMailer.booking_confirmation(booking).deliver_now
      redirect_to workshop_path(@workshop), notice: 'Your ticked has been booked'
    end
  rescue Stripe::StripeError => error
    redirect_to workshop_path(@workshop), alert: "#{error.message}"
  end

  def booking_details
    @booking = Booking.find(params[:id])
    @workshop = @booking.workshop
    @customer = @booking.customer
  end

  private

  def customer_params
    params.permit(:full_name, :email, :contact_number)
  end

  def card_token_params
    params.permit(:card_number, :cvv, :exp_month, :exp_year)
  end
end