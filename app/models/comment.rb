class Comment < ApplicationRecord
  belongs_to :patron
  belongs_to :book, touch: true

  validates :text,  presence: true
end
