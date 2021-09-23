class Note < ApplicationRecord
  belongs_to :user
  has_many :labelings
  has_many :labels, through: :labelings
end
