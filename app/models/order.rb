class Order < ApplicationRecord
  enum currency: {
    'PLN' => 0
  }

  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }

  def user_email
    user.email
  end

  def amount_in_cents
    (amount * 100).to_i
  end
end
