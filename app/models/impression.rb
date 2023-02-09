class Impression < ApplicationRecord
  #has_many :comments, dependent: :destroy
  #has_many :favorites, dependent: :destroy
  belongs_to :customer
  belongs_to :field
  
  validates :title, presence: true
  validates :name, presence: true
  validates :text, presence: true
  validates :field_id, presence: true
end
