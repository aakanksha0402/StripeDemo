json.extract! card, :id, :customer_id, :stripe_card_id, :default_card, :last_4, :brand, :exp_month, :exp_year, :created_at, :updated_at
json.url card_url(card, format: :json)
