class Comment < ApplicationRecord
  belongs_to :match
  belongs_to :owner

  #  validates :comment, presence: true, length: { minimum: 5 }
end
