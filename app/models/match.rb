class Match < ApplicationRecord
  belongs_to :from_owner_id
  belongs_to :to_owner_id
end
