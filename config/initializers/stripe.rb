Rails.configuration.stripe = {
  publishable_key: "pk_test_51M71cXAa7W4k6Y8xGkqfDVjHiNn528A1iYhbqfY2s5nnRZMYEHI8tOpogOi8UKKqUfM6xqXalILs1Uon0J5LH71D00PyHIYOi8",
  secret_key:      "sk_test_51M71cXAa7W4k6Y8xFvSZtphPo8Hoj0ebHPs0eEwbF6Z9wv4gIe7aSghzpwVNIaXvb8Nc5zTv9OVopyJNwIbjGTzt00nY2rovSz"
}

# Stripe.api_key = Rails.configuration.stripe[:secret_key]
Stripe.api_key = "sk_test_51M71cXAa7W4k6Y8xFvSZtphPo8Hoj0ebHPs0eEwbF6Z9wv4gIe7aSghzpwVNIaXvb8Nc5zTv9OVopyJNwIbjGTzt00nY2rovSz"
