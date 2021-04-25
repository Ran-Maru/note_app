class Label < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
end
