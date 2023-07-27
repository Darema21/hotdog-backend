class Comment < ApplicationRecord
  belongs_to :match

  #  validates :comment, presence: true, length: { minimum: 5 }
end
