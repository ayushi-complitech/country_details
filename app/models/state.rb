class State < ApplicationRecord
   acts_as_paranoid
  belongs_to :country
  has_many :cities, dependent: :destroy
  validates :name, :abbreviation, presence: true
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) } 
  
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

  def self.import_from_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      state_hash = {}
      state_hash[:name] = row['name']
      state_hash[:abbreviation] = row['abbreviation']
      state_hash[:country_id] = row['country_id']
      state_hash[:is_active] = row['is_active']

      State.find_or_create_by!(state_hash)
    end
  end 
end
