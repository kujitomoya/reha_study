class Field < ApplicationRecord
  has_many :impressions, dependent: :destroy
  
  validates :name, presence: true
end
