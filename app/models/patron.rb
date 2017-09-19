class Patron < ApplicationRecord
  has_many :comments
  has_many :checkouts

  validates :first_name, :last_name, :city, presence: true
end
