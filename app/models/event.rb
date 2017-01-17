class Event < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :rounds, dependent: :destroy
  has_many :contributors, dependent: :destroy
end
