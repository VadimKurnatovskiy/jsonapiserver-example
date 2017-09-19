class Publisher < ApplicationRecord
  has_many :books

  validates :name, :country,  presence: true
end
