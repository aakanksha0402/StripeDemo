class Card < ApplicationRecord
  belongs_to :customer

  def to_s
    "Ending with #{self.last_4} - #{self.exp_month}/#{self.exp_year}"
  end
end
