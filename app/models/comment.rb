class Comment < ApplicationRecord
  belongs_to :owner

  validates :message, presence: true, length: { minimum: 5 }
end
