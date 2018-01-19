class Customer < ApplicationRecord
  require "stripe"

  attr_accessor :card_number, :cvc, :exp_month, :exp_year

  validates :first_name, :last_name, :email, presence: true

  belongs_to :plan

  before_save :create_customer_in_stripe

  def create_customer_in_stripe
    begin
      token = Stripe::Token.create(
                  :card => {
                    :number => self.card_number,
                    :exp_month => self.exp_month,
                    :exp_year => self.exp_year,
                    :cvc => self.cvc
                  },
                )

      customer = Stripe::Customer.create(
        :description => "Customer for #{self.email}",
        :source => token[:id]
      )

      self.stripe_customer_id = customer[:id]

      subscription = Stripe::Subscription.create(
        :customer => self.stripe_customer_id,
        :items => [
          {
            :plan => self.plan.stripe_plan_id,
          },
        ]
      )

    rescue => e
      body = e.json_body
      err  = body[:error]
      errors.add(:base, err)
      throw(:abort)
    end
  end

  def to_s
    self.first_name + " " + self.last_name
  end
end
