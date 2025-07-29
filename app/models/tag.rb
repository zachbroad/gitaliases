class Tag < ApplicationRecord
  has_and_belongs_to_many :aliases
  
  validates :name, presence: true, uniqueness: true
  validates :color, presence: true
  
  scope :popular, -> { joins(:aliases).group('tags.id').order('COUNT(aliases.id) DESC') }
  
  def self.find_or_create_by_name(name)
    find_or_create_by(name: name.strip.downcase)
  end
end
