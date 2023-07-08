class Match < ApplicationRecord
  belongs_to :from_owner, class_name: 'Owner', foreign_key: 'from_owner_id'
  belongs_to :to_owner, class_name: 'Owner', foreign_key: 'to_owner_id'


end
