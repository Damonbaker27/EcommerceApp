class CheckoutController < ApplicationController
  def create
    # establish a connection to Stripe and then redirect the user to the payment screen
    Stripe.api_key = "sk_test_51M71cXAa7W4k6Y8xFvSZtphPo8Hoj0ebHPs0eEwbF6Z9wv4gIe7aSghzpwVNIaXvb8Nc5zTv9OVopyJNwIbjGTzt00nY2rovSz"
    @cart = Cart.find(session[:cart_id])
    subtotal = @cart.subtotal
    line_items = []
    @cart.orderables.each do |i|
      line_items << {
        price_data: {
          currency:     "cad",
          unit_amount:  (i.product.Price * 100).to_i,
          product_data: {
            name:        i.product.Name,
            description: i.product.Description.empty? ? @product.Description : "No Description Avaliable"
          },
          tax_behavior: "exclusive"
        },
        quantity:   i.quantity
      }
    end

    line_items << {
      price_data: {
        currency:     "cad",
        unit_amount:  (subtotal * 100 * current_user.province.tax.gst).to_i,
        product_data: {
          name:        "gst",
          description: "Goods and Services Tax"
        },
        tax_behavior: "exclusive"
      },
      quantity:   1
    }
    line_items << {
      price_data: {
        currency:     "cad",
        unit_amount:  (subtotal * 100 * current_user.province.tax.pst).to_i,
        product_data: {
          name:        "Pst",
          description: "Provincal Sales Tax"
        },
        tax_behavior: "exclusive"
      },
      quantity:   1
    }

    subtotal = @cart.subtotal

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url,
      cancel_url:           checkout_cancel_url,
      line_items:           line_items,

      mode:                 "payment"
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    # we took the customer's money
    redirect_to create_order_path(@cart.id)
    # @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    # @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # something went wrong with payment!
    redirect_to root_path
  end
end
