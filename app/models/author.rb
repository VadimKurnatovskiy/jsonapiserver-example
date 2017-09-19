class Author < ApplicationRecord
  has_many :books

  validates :first_name, :last_name, presence: true
  validates :year_of_birth, numericality: { greater_than: 0 }
end
