class AddBookingStripeId < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :stripe_customer_id, :string
  end
end
