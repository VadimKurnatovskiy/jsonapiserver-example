class Checkout < ApplicationRecord
  belongs_to :patron
  belongs_to :book, touch: true

  validates :checkout_date,  presence: true
end
