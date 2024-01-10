class City < ApplicationRecord
   acts_as_paranoid
  belongs_to :country
  belongs_to :state
  validates :name, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) } 
  
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

  def self.import_from_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      city_hash = {}
      city_hash[:name] = row['name']
      city_hash[:country_id] = row['country_id']
      city_hash[:state_id] = row['state_id']
      city_hash[:is_active] = row['is_active']

      City.find_or_create_by!(city_hash)
    end
  end 
end