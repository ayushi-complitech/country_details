class State < ApplicationRecord
  require 'csv'
  def self.to_csv
    states = all
    CSV.generate do |csv|
    csv << column_names
     states.each do |state|
     csv << state.attributes.values_at(*column_names)
    end
   end
  end
  acts_as_paranoid
  belongs_to :country
  has_many :cities, dependent: :destroy
  validates :name, :abbreviation, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }  
end
