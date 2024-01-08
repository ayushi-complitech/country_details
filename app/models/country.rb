class Country < ApplicationRecord
  require 'csv'
  def self.to_csv
    countries = all
    CSV.generate do |csv|
    csv << column_names
     countries.each do |country|
     csv << country.attributes.values_at(*column_names)
    end
   end
  end
  acts_as_paranoid
  has_many :states, dependent: :destroy
  has_many :cities, dependent: :destroy
  validates :name, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }  
end
