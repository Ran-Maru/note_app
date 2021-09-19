class Labeling < ApplicationRecord
  belongs_to :note
  belongs_to :label
  validates :note_id, presence: true
  validates :label_id, presence: true

  validates :note_id, uniqueness: { scope: :label_id }
end
