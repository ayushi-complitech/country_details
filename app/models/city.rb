class City < ApplicationRecord
  require 'csv'
  def self.to_csv
    cities = all
    CSV.generate do |csv|
    csv << column_names
     cities.each do |city|
     csv << city.attributes.values_at(*column_names)
    end
   end
  end
  acts_as_paranoid
  belongs_to :country
  belongs_to :state
  validates :name, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }  
end