class Customer < ApplicationRecord
  require "stripe"

  attr_accessor :card_number, :cvc, :exp_month, :exp_year

  validates :first_name, :last_name, :email, presence: true

  belongs_to :plan
  has_many :cards

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

      customer[:sources][:data].each do |card|
        customer_card = self.cards.new(stripe_card_id: card[:id], last_4: card[:last4], brand: card[:brand], exp_month: card[:exp_month], exp_year: card[:exp_year])
        customer_card.default_card = true if self.cards.count == 0        
      end

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
      errors.add(:base, e)
      throw(:abort)
    end
  end

  def to_s
    self.first_name + " " + self.last_name
  end
end
