class State < ApplicationRecord
  belongs_to :country
  has_many :cities, dependent: :destroy
  validates :name, :abbreviation, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }  
end
