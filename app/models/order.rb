class Order < ApplicationRecord
  enum currency: {
    'PLN' => 0
  }

  belongs_to :user
end
