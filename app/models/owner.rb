class Owner < ApplicationRecord
  has_one :dog
  has_many :from_matches, class_name: 'Match', foreign_key: 'from_owner_id'
  has_many :to_matches, class_name: 'Match', foreign_key: 'to_owner_id'
  has_many :comments

end

# need to check if need to validate wechat_id and if active as boolean should be mandatory or not
