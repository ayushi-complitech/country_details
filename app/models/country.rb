class Country < ApplicationRecord
  has_many :states, dependent: :destroy
  has_many :cities, dependent: :destroy
  validates :name, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }  
end
