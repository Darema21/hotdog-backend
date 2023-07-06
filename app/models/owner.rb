class Owner < ApplicationRecord
  has_one :dog
  has_many :matches

  validates: name, presence: true, length: { minimum: 2}
  validates: age, presence: true
  validates: gender, presence: true
  validates: bio, presence: true, , length: { minimum: 5}
  validates: active
end

# need to check if need to validate wechat_id and if active as boolean should be mandatory or not
