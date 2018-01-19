json.extract! plan, :id, :name, :amount, :interval, :desired_plan_id, :stripe_plan_id, :created_at, :updated_at
json.url plan_url(plan, format: :json)
