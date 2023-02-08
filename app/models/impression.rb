class Impression < ApplicationRecord
  #has_many :comments, dependent: :destroy
  #has_many :favorites, dependent: :destroy
  belongs_to :customer
  belongs_to :fields
end
