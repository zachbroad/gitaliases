class Alias < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :name, presence: true
  validates :description, presence: true
  validates :code, presence: true
end
