class Country < ApplicationRecord
  acts_as_paranoid
  has_many :states, dependent: :destroy
  has_many :cities, dependent: :destroy
  validates :name, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) } 
  
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

  def self.import_from_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      country_hash = {}
      country_hash[:name] = row['name']
      country_hash[:is_active] = row['is_active']

      Country.find_or_create_by!(country_hash)
    end
  end
end
