class Match < ApplicationRecord
  belongs_to :from_owner, class_name: 'Owner', foreign_key: 'from_owner_id'
  belongs_to :to_owner, class_name: 'Owner', foreign_key: 'to_owner_id'

  validates :from_owner_id, uniqueness: { scope: :to_owner_id, message: 'You can only have one match with the same owner.' }
  validate :cannot_match_with_self

  private

  def cannot_match_with_self
    if from_owner_id == to_owner_id
      errors.add(:base, "You cannot match with yourself.")
    end
  end
end
