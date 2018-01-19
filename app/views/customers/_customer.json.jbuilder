json.extract! customer, :id, :first_name, :last_name, :email, :plan_id, :stripe_customer_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)
