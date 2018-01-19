class Plan < ApplicationRecord
  require "stripe"

  validates :name, :amount, :interval, presence: true

  before_save :create_plan_in_stripe

  def create_plan_in_stripe
    begin
      plan = Stripe::Plan.create(
        :amount => (self.amount.to_f * 100).to_i,
        :interval => self.interval,
        :name => self.name,
        :currency => "usd",
        :id => self.desired_plan_id
      )

      self.stripe_plan_id = plan[:id]
    rescue => e
      body = e.json_body
      err  = body[:error]
      errors.add(:base, err)
      throw(:abort)
    end
  end

  def to_s
    self.name
  end
end
