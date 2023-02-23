class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :impression
  
  validates :comment, presence: true, length: { in: 1..50 }
end