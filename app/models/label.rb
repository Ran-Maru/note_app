class Label < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy

  validates :user_id, uniqueness: { scope: :name }
end
