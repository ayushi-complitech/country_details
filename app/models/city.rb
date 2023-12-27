class City < ApplicationRecord
  acts_as_paranoid
  belongs_to :country
  belongs_to :state
  validates :name, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }  
end