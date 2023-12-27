class State < ApplicationRecord
  acts_as_paranoid
  belongs_to :country
  has_many :cities, dependent: :destroy
  validates :name, :abbreviation, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }  
end
